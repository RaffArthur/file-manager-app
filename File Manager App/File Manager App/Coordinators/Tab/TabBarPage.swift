//
//  TabBarPage.swift
//  File Manager App
//
//  Created by Arthur Raff on 08.05.2022.
//

import Foundation
import UIKit

enum TabBarPage: CaseIterable {
    case files
    case settings
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .files
        case 1:
            self = .settings
        default:
            return nil
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .files:
            return 0
        case .settings:
            return 1
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .files:
            return "Файлы"
        case .settings:
            return "Настройки"
        }
    }
    
    func pageIconValue() -> UIImage {
        switch self {
        case .files:
            return UIImage(systemName: "folder.fill") ?? UIImage()
        case .settings:
            return UIImage(systemName: "gearshape.fill") ?? UIImage()
        }
    }
}
