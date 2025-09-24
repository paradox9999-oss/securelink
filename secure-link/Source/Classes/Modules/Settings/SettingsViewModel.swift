//
//  SettingsViewModel.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import UIKit
import Swinject

class SettingsInput {
    var resolver: Resolver
    var didChangePasscode: Completion?
    var didOpenSupport: Completion?
    var didSelectPaywall: Completion?
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

class SettingsViewModel {
    
    private var input: SettingsInput
 
    var groups: [SettingGroup]
    var faceIdEnable: Bool {
        return self.storageService.isFaceIDInstall
    }
    
    private var storageService: StorageService
    
    init(input: SettingsInput) {
        self.input = input
        self.storageService = input.resolver.resolve(StorageService.self)!
        
        let profile = SettingGroup(
            items: [.faceId, .changePasscode],
            title: "Profile settings"
        )
        let support = SettingGroup(
            items: [.contactUs],
            title: "Support"
        )
        let about = SettingGroup(
            items: [.termsOfUse, .privacyPolicy],
            title: "About"
        )
        
        groups = [profile, support, about]
    }
    
    func paywallBannerTapped() {
        self.input.didSelectPaywall?()
    }
    
    func didSelect(indexPath: IndexPath) {
        let items = self.groups[indexPath.section]
        let item = items.items[indexPath.row]
        
        switch item {
        case .privacyPolicy:
            UIApplication.shared.open(URL(string: Constants.URLs.privacy)!)
        case .termsOfUse:
            UIApplication.shared.open(URL(string: Constants.URLs.terms)!)
        case .contactUs:
            self.input.didOpenSupport?()
        case .changePasscode:
            self.input.didChangePasscode?()
        default:
            break
        }
    }
    
    func faceIdSwitched() {
        self.storageService.faceIDsetEnable(!self.storageService.isFaceIDInstall)
    }
    
    func bannerTapped() {
        self.input.didSelectPaywall?()
    }
    
}


