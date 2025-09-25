//
//  MainViewModel.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import UIKit
import Swinject
import NetworkExtension

class HomeInput {
    var resolver: Resolver
    var didSelectCountry: Completion?
    var didSettingTap: Completion?
    var didSpeedCheckerTap: Completion?
    var didShowPaywall: Completion?
    var didSelectCountryId: ((String) -> Void)?
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
}

class HomeViewModel {
    
    private var input: HomeInput
    
    private var apiService: APINetworkService
    private var storeService: StoreService
    private var storageService: StorageService
    private var speedService: SpeedServiceInterface
    
    private var creds: Country? {
        didSet {
            self.didUpdate?(self.creds)
        }
    }
    var didUpdate: ((Country?) -> Void)?
    var didUpdateTime: ((String?) -> Void)?
    var didChangeStatus: ((ConnectViewState) -> Void)?
    var didShowError: ((String) -> Void)?
    var didCheckSpeed: ((String, String) -> Void)?
    
    private var timer: Timer?
    
    init(input: HomeInput) {
        self.input = input
        self.apiService = input.resolver.resolve(APINetworkService.self)!
        self.storeService = input.resolver.resolve(StoreService.self)!
        self.storageService = input.resolver.resolve(StorageService.self)!
        self.speedService = input.resolver.resolve(SpeedServiceInterface.self)!
    }
    
    func selectServerTapped() {
        self.input.didSelectCountry?()
    }
    
    func viewDidLoad() {
        _ = VPNManager.shared
        vpnStateChanged(status: VPNManager.shared.status)
        VPNManager.shared.statusEvent.attach(self, HomeViewModel.vpnStateChanged)
        getCurrentServer()
        
        self.input.didSelectCountryId = { [weak self] id in
            guard let strongSelf = self else { return }
            
            self?.storageService.currentServerID = id
            
            Task {
                do {
                    let creds = try await strongSelf.apiService.application.creds(id: id)
                    strongSelf.creds = creds
                    
                    await MainActor.run {
                        strongSelf.didUpdate?(strongSelf.creds)
                    }
                } catch (let error) {
                    print(error)
                }
            }
            
        }
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: { [weak self] timer in
                self?.onTick()
        })
    }
    
    func getCurrentServer() {
        guard let currentServerID = storageService.currentServerID else { return }
        
        Task {
            do {
                let creds = try await self.apiService.application.creds(id: currentServerID)
                self.creds = creds
                
                await MainActor.run {
                    self.didUpdate?(self.creds)
                }
            } catch (let error) {
                await MainActor.run {
                    self.didShowError?(error.localizedDescription)
                }
                print(error)
            }
        }
    }
    
    private func getCheckSpeed() {
        self.speedService.checkForSpeedTest { [weak self] mb in
            self?.handleResult(mb: mb)
        }
    }
    
    private func handleResult(mb: Double?) {
        if var mb = mb {
            if mb <= 0 {
                mb = 0.5
            }
            let random = Double.random(in: 0...0.5)
            var upload = mb - random
            if upload <= 0 {
                upload = random
            }
            
            let downloadString = String(format: "%.2fmb", mb)
            let uploadString = String(format: "%.2fmb", upload)
            self.didCheckSpeed?(downloadString, uploadString)
        } else {
            let downloadString = "0.00mb"
            let uploadString = "0.00mb"
            self.didCheckSpeed?(downloadString, uploadString)
        }
    }
    
    private func vpnStateChanged(status: NEVPNStatus) {
        switch status {
            case .invalid:
                self.storageService.lastConnection = nil
            case .disconnected, .reasserting:
                self.storageService.lastConnection = nil
                self.didChangeStatus?(.disconnect)
                self.getCheckSpeed()
            case .connected:
                self.storageService.lastConnection = Int(Date().timeIntervalSince1970)
                self.didChangeStatus?(.connect)
                self.getCheckSpeed()
            case .connecting:
                self.didChangeStatus?(.connecting)
            case .disconnecting:
                self.storageService.lastConnection = nil
                self.didChangeStatus?(.disconnecting)
            @unknown default: break
        }
    }
    
    func loadConfig() {
        
    }
    
    func countryButtonTapped() {
        self.input.didSelectCountry?()
    }
    
    func settingsButtonTapped() {
        self.input.didSettingTap?()
    }
    
    func bannerButtonTapped() {
        self.input.didSpeedCheckerTap?()
    }
    
    func connectTapped() {
        if VPNManager.shared.isDisconnected {
            if self.storeService.hasUnlockedPro == false {
                self.input.didShowPaywall?()
                return
            }
            
            connect()
        } else {
            VPNManager.shared.disconnect()
        }
    }
    
    private func connect() {
        guard let server = self.creds else {
            self.didShowError?("Select server")
            return
        }
        
        let config = Configuration(server: server.id,
                                   account: server.username,
                                   password: server.password,
                                   onDemand: false,
                                   psk: nil)
        VPNManager.shared.connectIKEv2(config: config) { (success) in
//            self.tableView.reloadData()
        } onError: { (error) in
//            self.tableView.reloadData()
        }
    }
    
    private func onTick() {
        let dateString: String? = {
            if let lastConnection = storageService.lastConnection, lastConnection > 0 {
                let lastDate = Date(timeIntervalSince1970: TimeInterval(lastConnection))
                let distance = Date.timeDifference(from: lastDate, to: Date())
                return distance
            } else {
                return nil
            }
        }()
        self.didUpdateTime?(dateString)
    }
    
    
}
