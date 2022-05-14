//
//  UserSettingsConfigurator.swift
//  File Manager App
//
//  Created by Arthur Raff on 05.05.2022.
//

import Foundation
import UIKit

final class UserSettingsConfigurator {
    static func configureSections() -> [SettingsSection] {
        let sortFilesOption = SettingsSwitchOption(type: .sortFiles,
                                                   title: "Сортировка файлов",
                                                   icon: "arrow.up.arrow.down.square.fill",
                                                   iconTintColor: .systemYellow)
        
        let changePasswordOption = SettingsStaticOption(type: .changePassword,
                                                        title: "Смена пароля",
                                                        icon: "lock.square.fill",
                                                        iconTintColor: .systemBlue)
        
        return [SettingsSection(title: "Приложение",
                                options: [.switchCell(option: sortFilesOption)]),
                SettingsSection(title: "Конфиденциальность",
                                options: [.staticCell(option: changePasswordOption)])]
    }
}
