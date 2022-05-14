//
//  RegistrationViewController.swift
//  File Manager App
//
//  Created by Arthur Raff on 29.04.2022.
//

import Foundation
import UIKit

final class RegistrationViewController: UIViewController {
    weak var reviewer: AuthentificationReviewer?
    weak var delegate: RegistrationViewControllerDelegate?
    
    private lazy var registrationView = RegistrationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registrationView.delegate = self
        
        setupScreen()
    }
}

private extension RegistrationViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        view.addSubview(registrationView)
        
        registrationView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupContent() {
        view.backgroundColor = .systemIndigo
        
        UITextField.appearance().tintColor = .white
    }
}

private extension RegistrationViewController {
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

extension RegistrationViewController: RegistrationViewDelegate {
    func didTapRegistrationButton() {
        guard let password = registrationView.userPassword,
              let repeatPassword = registrationView.userRepeatPassword
        else {
            return
        }
        
        let credentials = AuthentificationCredentials(userName: UIDevice.current.name,
                                                      oldPassword: nil,
                                                      password: password,
                                                      repeatPassword: repeatPassword)
        
        reviewer?.createAnAccountWith(credentials: credentials) { result in
            switch result {
            case .success:
                self.delegate?.didUserRegistered()
            case .failure(let error):
                self.show(error: error)
            }
        }
    }
    
    func didTapHaveAnAccountButton() {
        delegate?.didUserGoToLogin()
    }
}
