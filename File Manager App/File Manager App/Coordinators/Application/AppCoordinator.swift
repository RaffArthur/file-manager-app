//
//  AppCoordinator.swift
//  File Manager App
//
//  Created by Arthur Raff on 08.05.2022.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .application }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        showLoginFlow()
    }
    
    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(navigationController)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        
        childCoordinators.append(loginCoordinator)
    }
    
    func showAppFlow() {
        let tabCoordinator = TabCoordinator(navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        
        childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
        
        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()
            
            showLoginFlow()
        case .login:
            navigationController.viewControllers.removeAll()
            
            showAppFlow()
        default:
            break
        }
    }
}
