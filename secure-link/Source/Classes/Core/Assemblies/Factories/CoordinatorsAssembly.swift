import Swinject
import UIKit

final class CoordinatorsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AppCoordinator.self) { (r, navigationController: UINavigationController) in
            AppCoordinator(
                assembler: r.resolve(Assembler.self)!,
                navigationController: navigationController
            )
        }
    }
    
}
