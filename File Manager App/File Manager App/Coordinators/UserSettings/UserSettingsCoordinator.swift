//
//  UserSettingsCoordinator.swift
//  File Manager App
//
//  Created by Arthur Raff on 08.05.2022.
//

import Foundation
import UIKit

final class UserSettingsCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .settings }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userSettingsVC = UserSettingsViewController()
        userSettingsVC.delegate = self
        
        navigationController.pushViewController(userSettingsVC, animated: true)
    }
}

extension UserSettingsCoordinator: UserSettingsViewControllerDelegate {
    func didChangePasswordCellTapped() {
        let coordinator = ChangePasswordCoordinator(navigationController)
        
        childCoordinators.append(coordinator)
        
        coordinator.start()
    }
}
