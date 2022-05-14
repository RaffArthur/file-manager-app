//
//  KeychainAccessError.swift
//  File Manager App
//
//  Created by Arthur Raff on 02.05.2022.
//

import Foundation

enum KeychainAccessError: Error {
    case wrongPassword
    case weakPassword
    case wrongOldPassword
    case userAlreadyExist
    case unknownError
}
