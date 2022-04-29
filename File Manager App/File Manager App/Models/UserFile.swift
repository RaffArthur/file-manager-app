//
//  UserFile.swift
//  File Manager App
//
//  Created by Arthur Raff on 29.04.2022.
//

import Foundation

struct UserFile: Codable {
    let url: String?
    let name: String?
    let size: String?
    let format: String?
    let creationDate: String?
}
