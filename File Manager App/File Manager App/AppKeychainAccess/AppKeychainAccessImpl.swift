//
//  AppKeychainAccessImpl.swift
//  File Manager App
//
//  Created by Arthur Raff on 01.05.2022.
//

import Foundation
import KeychainAccess

final class AppKeychainAccessImpl: AppKeychainAccess {    
    private var keychain = Keychain(service: Bundle.main.bundleIdentifier ?? String())
    
    func createUserWith(credentials: AuthentificationCredentials,
                        completion: KeychainAccessResult) {
        guard let userName = credentials.userName,
              let password = credentials.password
        else {
            return
        }
        
        if !password.isValidPassword() {
            completion?(nil, .weakPassword)
        } else if keychain[userName] != nil {
            completion?(nil, .userAlreadyExist)
        } else {
            keychain[userName] = password
            
            completion?(keychain, nil)
        }
    }
    
    func loginWith(credentials: AuthentificationCredentials,
                   completion: KeychainAccessResult) {
        guard let userName = credentials.userName,
              let password = credentials.password
        else {
            return
        }
        
        if password != keychain[userName] {
            completion?(nil, .wrongPassword)
        } else {
            completion?(keychain, nil)
        }
    }
    
    func removeUserWith(credentials: AuthentificationCredentials) {
        guard let userName = credentials.userName else { return }
        
        keychain[userName] = nil
    }
}
