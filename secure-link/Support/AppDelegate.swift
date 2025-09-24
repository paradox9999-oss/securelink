//
//  AppDelegate.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var assembler: Assembler!
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupAssembler()
        setupDependencies()
        setupNavigation()
        
        return true
    }
    
    func setupAssembler() {
        let container = Container()

        let factory = AppAssemblyFactory()
        assembler = Assembler(
            factory.makeAppAssemblies(),
            container: container
        )
        
        container.register(Assembler.self) { _ in
            self.assembler
        }.inObjectScope(.container)
    }
    
    func setupDependencies() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        // Setup navigation
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController

        // Create and start coordinator
        appCoordinator = assembler.resolver.resolve(AppCoordinator.self, argument: navigationController)
        appCoordinator?.start()

        window?.makeKeyAndVisible()
    }
    
    private func setupNavigation() {
        let appearance = UINavigationBar.appearance()
//        let backImage = Asset.navagationBack.image
//        appearance.backIndicatorImage = backImage
//        appearance.backIndicatorTransitionMaskImage = backImage
//        appearance.tintColor = Asset.grayscale700.color
        
        appearance.titleTextAttributes = [
            .foregroundColor: Asset.mainLightGrey.color,
            .font: FontFamily.RedHatDisplay.medium.font(size: 24)
        ]
    }

}

