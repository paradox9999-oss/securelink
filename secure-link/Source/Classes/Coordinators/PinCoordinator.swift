import Foundation
import UIKit
import Swinject

final class PinCoordinator: Coordinate {
    var childCoordinators: [Coordinate] = []
    var navigationController: UINavigationController

    var didEnd: Completion?
    
    private let resolver: Resolver
    private var storage: StorageService

    init(
        resolver: Resolver,
        navigationController: UINavigationController
    ) {
        self.resolver = resolver
        self.navigationController = navigationController
        self.storage = resolver.resolve(StorageService.self)!
    }

    func start() {
        if self.storage.isPasscodeInstall {
            showEnterPasscode()
        } else {
            showSetupPasscode()
        }
    }
    
    func reset() {
        self.storage.resetPasscode()
        self.showSetupPasscode()
    }
    
    func showSetupPasscode() {
        let input = PinInput(
            resolver: self.resolver,
            state: .setup
        )
        let module = AppModule(pinInput: input)
        input.didEnd = { [weak self] state in
            module.viewController.dismiss(
                animated: false,
                completion: { [weak self] in
                    self?.start()
                }
            )
        }
        module.viewController.modalPresentationStyle = .fullScreen
        self.navigationController.present(module.viewController, animated: true)
    }
    
    func showEnterPasscode() {
        let input = PinInput(
            resolver: self.resolver,
            state: .enter
        )
        let module = AppModule(pinInput: input)
        let vc = module.viewController
        input.didEnd = { [weak self] state in
            DispatchQueue.main.async {
                vc.dismiss(animated: true) { [weak self] in
                    self?.didEnd?()
                }
            }
        }
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.present(vc, animated: true)
        }
    }
    
    func finish() {}
}

