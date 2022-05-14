//
//  LoginViewController.swift
//  File Manager App
//
//  Created by Arthur Raff on 03.05.2022.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    weak var reviewer: AuthentificationReviewer?
    weak var delegate: LoginViewControllerDelegate?
    
    private lazy var loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self
        
        setupScreen()
    }
}

private extension LoginViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        view.addSubview(loginView)
        
        loginView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupContent() {
        view.backgroundColor = .systemIndigo
    }
}

private extension LoginViewController {
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

extension LoginViewController: LoginViewDelegate {
    func didTapLoginButton() {
        guard let password = loginView.userPassword else { return }
        
        let credentials = AuthentificationCredentials(userName: UIDevice.current.name,
                                                      oldPassword: nil,
                                                      password: password,
                                                      repeatPassword: nil)
        
        reviewer?.loginWith(credentials: credentials) { result in
            switch result {
            case .success:
                self.delegate?.didUserLoggedIn()
            case .failure(let error):
                self.show(error: error)
            }
        }
    }
    
    func didTapNoAccountButton() {
        delegate?.didUserGoToRegistration()
    }
}
