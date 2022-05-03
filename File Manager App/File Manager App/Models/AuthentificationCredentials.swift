//
//  AuthentificationCredentials.swift
//  File Manager App
//
//  Created by Arthur Raff on 01.05.2022.
//

import Foundation

struct AuthentificationCredentials: Codable {
    let userName: String?
    let password: String?
    let repeatPassword: String?
}
