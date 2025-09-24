//
//  CommonModule.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import UIKit

class CommonModule {
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

class AppModule: CommonModule {
    
    init(splashInput: SplashInput) {
        let viewModel = SplashViewModel(input: splashInput)
        let viewController = SplashViewController()
        viewController.viewModel = viewModel
        super.init(viewController: viewController)
    }
    
    init(homeInput: HomeInput) {
        let viewModel = HomeViewModel(input: homeInput)
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        super.init(viewController: viewController)
    }
    
    init(pinInput: PinInput) {
        let viewModel = PinViewModel(input: pinInput)
        let viewController = PinViewController()
        viewController.viewModel = viewModel
        super.init(viewController: viewController)
    }
    
    init(settingsInput: SettingsInput) {
        let viewModel = SettingsViewModel(input: settingsInput)
        let viewController = SettingsViewController()
        viewController.viewModel = viewModel
        super.init(viewController: viewController)
    }
    
    init(serversInput: ServersInput) {
        let viewModel = ServersViewModel(input: serversInput)
        let viewController = ServersViewController()
        viewController.viewModel = viewModel
        super.init(viewController: viewController)
    }
    
    init(paywallInput: PaywallInput) {
        let viewModel = PaywallViewModel(input: paywallInput)
        let viewController = PaywallViewController()
        viewController.viewModel = viewModel
        super.init(viewController: viewController)
    }
    
}
