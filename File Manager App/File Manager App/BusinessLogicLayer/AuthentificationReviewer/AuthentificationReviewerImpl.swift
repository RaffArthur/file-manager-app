//
//  AuthentificationReviewerImpl.swift
//  File Manager App
//
//  Created by Arthur Raff on 01.05.2022.
//

import Foundation
import KeychainAccess

final class AuthentificationReviewerImpl: AuthentificationReviewer {
    let appKeychainAccess = AppKeychainAccessImpl()
    
    func loginWith(credentials: AuthentificationCredentials,
                   completion: @escaping AuthentificationResult) {
        guard let password = credentials.password else { return }
        
        let inputDataValidationError = loginValidation(password: password)
        
        guard inputDataValidationError == nil else {
            inputDataValidationError.flatMap { completion(.failure($0))}
            
            return
        }
        
        appKeychainAccess.loginWith(credentials: credentials) { result, error in
            guard error == nil else {
                if error == .wrongPassword {
                    completion(.failure(.wrongPassword))
                }
                
                if error == .unknownError {
                    completion(.failure(.unknownError))
                }
                
                return
            }
            
            guard let result = result else { return }
            completion(.success(result))
        }
    }
    
    func createAnAccountWith(credentials: AuthentificationCredentials,
                             completion: @escaping AuthentificationResult) {
        guard let password = credentials.password,
              let repeatPassword = credentials.repeatPassword
        else {
            return
        }

        let inputDataValidationError = creatingAnAccountValidation(password: password,
                                                                   repeatPassword: repeatPassword)
        
        guard inputDataValidationError == nil else {
            inputDataValidationError.flatMap { completion(.failure($0))}
            
            return
        }
        
        appKeychainAccess.createUserWith(credentials: credentials) { result, error in
            guard error == nil else {
                if error == .weakPassword {
                    completion(.failure(.weakPassword))
                }
                
                if error == .userAlreadyExist {
                    completion(.failure(.userAlreadyExist))
                }
                
                if error == .unknownError {
                    completion(.failure(.unknownError))
                }
                
                return
            }
            
            guard let result = result else { return }
            completion(.success(result))
        }
    }
}

extension AuthentificationReviewerImpl {
    func creatingAnAccountValidation(password: String,
                                     repeatPassword: String) -> AuthentificationError? {
        if password.isEmpty || repeatPassword.isEmpty {
            return .emptyFields
        }
        
        if repeatPassword != password {
            return .mismatchPasswords
        }
        
        return nil
    }
    
    func loginValidation(password: String) -> AuthentificationError? {
        if password.isEmpty {
            return .emptyFields
        }
        
        return nil
    }
}
