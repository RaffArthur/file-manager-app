//
//  LoginViewController.swift
//  File Manager App
//
//  Created by Arthur Raff on 03.05.2022.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    private let loginView = LoginView()
    let authentificationReviwer = AuthentificationReviewerImpl()
    
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
        
        let credentials = AuthentificationCredentials(userName: "MOKKO",
                                                      password: password,
                                                      repeatPassword: nil)
        
        authentificationReviwer.loginWith(credentials: credentials) { result in
            switch result {
            case .success:
                let vc = UserFilesViewController(fileManager: AppFileManagerImpl())
                
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                self.show(error: error)
            }
        }
    }
    
    func didTapNoAccountButton() {
        navigationController?.popViewController(animated: true)
    }
}
