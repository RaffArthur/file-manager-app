//
//  LoginCoordinator.swift
//  File Manager App
//
//  Created by Arthur Raff on 08.05.2022.
//

import Foundation
import UIKit

final class LoginCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }
    
    let reviewer = AuthentificationReviewerImpl()
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController()
        
        loginVC.reviewer = reviewer
        loginVC.delegate = self
        
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func didUserLoggedIn() {
        let coordinator = TabCoordinator(navigationController)
        
        childCoordinators.append(coordinator)
        
        coordinator.start()
    }
    
    func didUserGoToRegistration() {
        let coordinator = RegistrationCoordinator(navigationController)
        
        childCoordinators.append(coordinator)
        
        coordinator.start()
    }
}
