//
//  UserSettings.swift
//  File Manager App
//
//  Created by Arthur Raff on 08.05.2022.
//

import Foundation
import UIKit

struct SettingsSection {
    let title: String?
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case switchCell(option: SettingsSwitchOption)
    case staticCell(option: SettingsStaticOption)
}

struct SettingsSwitchOption {
    let type: OptionType?
    let title: String?
    let icon: String?
    let iconTintColor: UIColor?
}

struct SettingsStaticOption {
    let type: OptionType?
    let title: String?
    let icon: String?
    let iconTintColor: UIColor?
}

enum OptionType: String {
    case sortFiles
    case changePassword
}
