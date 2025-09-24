//
//  MainCoordinator.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import UIKit
import Swinject
import MessageUI

final class MainCoordinator: NSObject, Coordinate {
    var childCoordinators: [Coordinate] = []
    var navigationController: UINavigationController
    
    private let resolver: Resolver
    private var homeInput: HomeInput?

    init(
        resolver: Resolver,
        navigationController: UINavigationController
    ) {
        self.resolver = resolver
        self.navigationController = navigationController
    }

    func start() {
        setupTab()
    }
    
    private func setupTab() {
        let tabController = TabBarController()
        
        let homeInput = HomeInput(resolver: self.resolver)
        homeInput.didSelectCountry = { [weak self] in
            self?.showServers()
        }
        self.homeInput = homeInput
        homeInput.didShowPaywall = { [weak self] in
            self?.showPaywall()
        }
        let homeModule = AppModule(homeInput: homeInput)
        
        let settingsInput = SettingsInput(resolver: self.resolver)
        let settingsModule = AppModule(settingsInput: settingsInput)
        settingsInput.didSelectPaywall = { [weak self] in
            self?.showPaywall()
        }
        
        let homeNav = TabNavigationController(tab: .home, root: homeModule.viewController)
        let settingsNav = TabNavigationController(tab: .settings, root: settingsModule.viewController)
        
        tabController.set(items: [homeNav, settingsNav])

        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.setViewControllers([tabController], animated: true)
    }
    
    func showServers() {
        let input = ServersInput(resolver: self.resolver)
        let module = AppModule(serversInput: input)
        input.didSelect = { [weak self] id in
            self?.homeInput?.didSelectCountryId?(id)
            self?.navigationController.popViewController(animated: true)
        }
        self.navigationController.pushViewController(
            module.viewController,
            animated: true
        )
    }
//    
//    func showSettings() {
//        let input = SettingsModuleInput(resolver: self.resolver)
//        input.didSelectPaywall = { [weak self] in
//            self?.showPaywall()
//        }
//        input.didChangePasscode = { [weak self] in
//            self?.showChangePasscode()
//        }
//        input.didOpenSupport = { [weak self] in
//            self?.openMailbox(email: Constants.URLs.support)
//        }
//        let module = SettingsModule()
//        module.configure(with: input)
//        self.navigationController.pushViewController(module.toPresent, animated: true)
//    }
//    
//    func showSpeedCheck() {
//        let input = SpeedCheckerModuleInput(resolver: self.resolver)
//        input.didSelectPaywall = { [weak self] in
//            self?.showPaywall()
//        }
//        let module = SpeedCheckerModule()
//        module.configure(with: input)
//        self.navigationController.pushViewController(module.toPresent, animated: true)
//    }
//    
    func showPaywall() {
        let input = PaywallInput(resolver: self.resolver)
        let module = AppModule(paywallInput: input)
        let vc = module.viewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController.present(vc, animated: true)
    }
//    
//    func showChangePasscode() {
//        let secureCoordinator = SecurityCoordinator(
//            resolver: self.resolver,
//            navigationController: self.navigationController
//        )
//        secureCoordinator.reset()
//        secureCoordinator.didEnd = { [weak self] in
//            self?.removeChildCoordinator(secureCoordinator)
//        }
//        addChildCoordinator(secureCoordinator)
//    }
//    
//    private func openMailbox(email: String) {
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = self
//            mail.setToRecipients([email])
//            self.navigationController.present(mail, animated: true)
//        }
//    }
    
    func finish() {}
}

extension MainCoordinator: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: (any Error)?) {
        controller.dismiss(animated: true)
    }
    
}
