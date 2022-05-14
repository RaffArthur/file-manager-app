//
//  UITextField+PasswordValidation.swift
//  File Manager App
//
//  Created by Arthur Raff on 02.05.2022.
//

import Foundation
import UIKit

extension String {
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[0-9]).{4,}$"
        
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
