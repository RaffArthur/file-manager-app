//
//  UITextField+PasswordVisibilityToggle.swift
//  File Manager App
//
//  Created by Arthur Raff on 01.05.2022.
//

import UIKit

extension UITextField {
    func enablePasswordVisibiltyToggle() {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        button.tintColor = UIColor.white.withAlphaComponent(0.4)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        
        self.rightView = button
        self.rightViewMode = .always
    }
}

private extension UITextField {
    @objc func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        
        guard let button = sender as? UIButton else { return }
        
        button.isSelected.toggle()
    }
}
