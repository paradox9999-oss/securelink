//
//  PinViewModel.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import Swinject
import LocalAuthentication

class PinInput {
    
    var didEnd: ((PinState) -> Void)?
    var state: PinState
    var resolver: Resolver
    
    init(resolver: Resolver, state: PinState) {
        self.resolver = resolver
        self.state = state
    }
    
}

enum PinState {
    case enter
    case setup
    
    var title: String {
        switch self {
        case .enter:
            return "Enter code"
        case .setup:
            return "Setup code"
        }
    }
}

protocol Alertable {
    var didShowAlert: ((String) -> Void)? { get set }
}

class PinViewModel: ObservableObject, Alertable {
    
    var didShowAlert: ((String) -> Void)?

    static let numberOfPins: Int = 4
    private var input: PinInput
    private var storage: StorageService
    private var passcode: String = "" {
        didSet {
            self.didUpdateUI?()
            if passcode.count >= Self.numberOfPins {
                self.handlePasscode()
            }
        }
    }
    
    var state: PinState = .setup
    var inputNumberCount: Int? {
        if self.passcode.isEmpty {
            return nil
        }
        return self.passcode.count
    }
    var didUpdateUI: Completion?
    
    init(input: PinInput) {
        self.input = input
        self.storage = input.resolver.resolve(StorageService.self)!
        self.state = input.state
    }
    
    func keyButtonTapped(key: String) {
        self.passcode.append(key)
    }
    
    func backButtonTapped() {
        if !self.passcode.isEmpty {
            self.passcode.removeLast()
        }
    }
    
    func viewDidLoad() {
        self.didUpdateUI?()
        
        if self.storage.isFaceIDInstall == true {
            self.auth()
        }
    }
    
    private func auth() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self?.input.didEnd?(.enter)
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometry
        }
    }
    
    func faceIDDidTap() {
        self.auth()
    }
    
    private func handlePasscode() {
        if self.state == .setup {
            if self.passcode.count == 4 {
                self.storage.savePasscode(code: self.passcode)
                self.passcode = ""
                self.input.didEnd?(.setup)
                return
            }
        }
        
        if self.state == .enter {
            if self.passcode.count == 4 {
                if self.storage.compare(code: self.passcode) == true {
                    self.passcode = ""
                    self.input.didEnd?(.enter)
                } else {
                    self.passcode = ""
                    self.didUpdateUI?()
                    self.didShowAlert?("Incorrect passcode")
                }
            }
        }
    }
    
}
