//
//  RegistrationCoordinator.swift
//  File Manager App
//
//  Created by Arthur Raff on 08.05.2022.
//

import Foundation
import UIKit

final class RegistrationCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .registration }
    
    let reviewer = AuthentificationReviewerImpl()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let registrationVC = RegistrationViewController()
        
        registrationVC.reviewer = reviewer
        registrationVC.delegate = self
        
        navigationController.show(registrationVC, sender: nil)
    }
}

extension RegistrationCoordinator: RegistrationViewControllerDelegate {
    func didUserRegistered() {
        let coordinator = TabCoordinator(navigationController)
        
        childCoordinators.append(coordinator)
        
        coordinator.start()
    }
    
    func didUserGoToLogin() {
        let coordinator = LoginCoordinator(navigationController)
        
        childCoordinators.append(coordinator)
        
        coordinator.finish()
    }
}
