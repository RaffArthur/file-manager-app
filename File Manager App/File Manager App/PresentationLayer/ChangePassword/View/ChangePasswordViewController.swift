//
//  ChangePasswordViewController.swift
//  File Manager App
//
//  Created by Arthur Raff on 09.05.2022.
//

import Foundation
import UIKit

final class ChangePasswordViewController: UIViewController {
    weak var reviewer: AuthentificationReviewer?
    weak var delegate: ChangePasswordViewControllerDelegate?
    
    private lazy var changePasswordView = ChangePasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changePasswordView.delegate = self
        
        setupScreen()
    }
}

private extension ChangePasswordViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        view.addSubview(changePasswordView)
        
        changePasswordView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupContent() {
        view.backgroundColor = .systemIndigo
    }
}

private extension ChangePasswordViewController {
    func show(error: AuthentificationError) {
        let alertController = UIAlertController(title: error.title,
                                                message: error.message,
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ОК",
                                   style: .cancel,
                                   handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ChangePasswordViewController: ChangePasswordViewDelegate {
    func didTapChangePasswordButton() {
        guard let oldPassword = changePasswordView.userOldPassword,
              let newPassword = changePasswordView.userNewPassword,
              let repeatNewPassword = changePasswordView.userRepeatNewPassword
        else {
            return
        }
        
        let credentials = AuthentificationCredentials(userName: "MOKKO",
                                                      oldPassword: oldPassword,
                                                      password: newPassword,
                                                      repeatPassword: repeatNewPassword)
        
        reviewer?.changePasswordWith(credentials: credentials) { result in
            switch result {
            case .success:
                self.delegate?.didUserPasswordChanged()
            case .failure(let error):
                self.show(error: error)
            }
        }
    }
}
