//
//  AppCoordinator.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import UIKit
import Swinject
import Combine

final class AppCoordinator: Coordinate {
    var childCoordinators: [Coordinate] = []
    var navigationController: UINavigationController

    private let assembler: Assembler
    private var resetAppCancellation: AnyCancellable?

    init(
        assembler: Assembler,
        navigationController: UINavigationController
    ) {
        self.assembler = assembler
        self.navigationController = navigationController
    }

    func start() {
        showSplashFlow()
    }
    
    func showSplashFlow() {
        let input = SplashInput(resolver: self.assembler.resolver)
        input.didLoad = { [weak self] in
            self?.showPin()
        }
        let module = AppModule(splashInput: input)
        self.navigationController.setViewControllers(
            [module.viewController],
            animated: false
        )
    }
    
    func showPin() {
        let pinCoordinator = PinCoordinator(
            resolver: self.assembler.resolver,
            navigationController: self.navigationController
        )
        addChildCoordinator(pinCoordinator)
        pinCoordinator.didEnd = { [weak self] in
            self?.removeChildCoordinator(pinCoordinator)
            self?.showMain()
        }
        pinCoordinator.start()
    }
    
    func showMain() {
        let mainCoordinator = MainCoordinator(
            resolver: self.assembler.resolver,
            navigationController: self.navigationController
        )
        addChildCoordinator(mainCoordinator)
        mainCoordinator.start()
    }
    
    func finish() {}
}

