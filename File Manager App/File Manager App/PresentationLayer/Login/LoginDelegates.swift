//
//  LoginDelegates.swift
//  File Manager App
//
//  Created by Arthur Raff on 03.05.2022.
//

import Foundation

protocol LoginViewDelegate: AnyObject {
    func didTapLoginButton()
    func didTapNoAccountButton()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didUserLoggedIn()
    func didUserGoToRegistration()
}
