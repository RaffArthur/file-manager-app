//
//  ChangePasswordCoordinator.swift
//  File Manager App
//
//  Created by Arthur Raff on 09.05.2022.
//

import Foundation
import UIKit

final class ChangePasswordCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .changePassword }
    
    let reviewer = AuthentificationReviewerImpl()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let changePasswordVC = ChangePasswordViewController()
        
        changePasswordVC.reviewer = reviewer
        changePasswordVC.delegate = self
        
        navigationController.present(changePasswordVC, animated: true)
    }
}

extension ChangePasswordCoordinator: ChangePasswordViewControllerDelegate {
    func didUserPasswordChanged() {
        
        navigationController.dismiss(animated: true) {
            self.showPasswordChangedAlert()
        }
    }
    
    private func showPasswordChangedAlert() {
        let alert = UIAlertController(title: "Успех!",
                                      message: "Пароль был успешно изменен!",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ОК",
                                   style: .cancel)
        
        alert.addAction(action)
        
        navigationController.present(alert, animated: true)
    }
}
