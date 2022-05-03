//
//  AppKeychainAccess.swift
//  File Manager App
//
//  Created by Arthur Raff on 01.05.2022.
//

import Foundation

import KeychainAccess

typealias KeychainAccessResult = ((Keychain?, KeychainAccessError?) -> Void)?

protocol AppKeychainAccess: AnyObject {
    func createUserWith(credentials: AuthentificationCredentials,
                        completion: KeychainAccessResult)
    
    func loginWith(credentials: AuthentificationCredentials,
                   completion: KeychainAccessResult)
    
    func removeUserWith(credentials: AuthentificationCredentials)
}
