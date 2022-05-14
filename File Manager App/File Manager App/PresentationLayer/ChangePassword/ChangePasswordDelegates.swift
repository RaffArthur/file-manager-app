//
//  ChangePasswordDelegates.swift
//  File Manager App
//
//  Created by Arthur Raff on 09.05.2022.
//

import Foundation

protocol ChangePasswordViewDelegate: AnyObject {
    func didTapChangePasswordButton()
}

protocol ChangePasswordViewControllerDelegate: AnyObject {
    func didUserPasswordChanged()
}
