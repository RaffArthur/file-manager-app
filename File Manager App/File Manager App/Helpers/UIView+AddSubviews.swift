//
//  UIView+AddSubviews.swift
//  File Manager App
//
//  Created by Arthur Raff on 29.04.2022.
//

import Foundation
import UIKit

extension UIView {
    func add(subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}
