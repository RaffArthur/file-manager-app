//
//  SettingsKeys.swift
//  File Manager App
//
//  Created by Arthur Raff on 13.05.2022.
//

import Foundation

enum SettingsKeys: String {
    case sortFiles
    
    var key: String {
        switch self {
        case .sortFiles:
            return rawValue
        }
    }
}
