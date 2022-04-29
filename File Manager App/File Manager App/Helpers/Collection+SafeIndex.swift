//
//  Collection+SafeIndex.swift
//  File Manager App
//
//  Created by Arthur Raff on 29.04.2022.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
