//
//  Coordinate.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import UIKit

protocol Coordinate: AnyObject {
    var childCoordinators: [Coordinate] { get set }

    func start()
    func clearChildCoordinators()
    func finish()

}

extension Coordinate {
    func addChildCoordinator(_ coordinator: Coordinate) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.forEach { $0.removeAllChildCoordinators() }
        childCoordinators = []
    }

    func removeChildCoordinator(_ coordinator: Coordinate) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    func getChildCoordinators<T: Coordinate>(ofType type: T.Type) -> [T] {
        var coordinatorsOfType: [T] = []

        for child in childCoordinators {
            if let coordinatorOfType = child as? T {
                coordinatorsOfType.append(coordinatorOfType)
            }
            coordinatorsOfType += child.getChildCoordinators(ofType: type)
        }

        return coordinatorsOfType
    }
    
    func clearChildCoordinators() {
        for child in childCoordinators {
            child.clearChildCoordinators()
        }
        childCoordinators = []
        finish()
    }

}
