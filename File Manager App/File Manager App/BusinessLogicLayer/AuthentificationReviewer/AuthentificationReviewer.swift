//
//  AuthentificationReviewer.swift
//  File Manager App
//
//  Created by Arthur Raff on 01.05.2022.
//

import Foundation

protocol AuthentificationReviewer: AnyObject {
    typealias AuthentificationResult = (Result<Any, AuthentificationError>) -> Void
    
    func loginWith(credentials: AuthentificationCredentials,
                   completion: @escaping AuthentificationResult)
    
    func createAnAccountWith(credentials: AuthentificationCredentials,
                             completion: @escaping AuthentificationResult)
}
