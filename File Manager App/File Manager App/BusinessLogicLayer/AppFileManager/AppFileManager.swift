//
//  AppFileManager.swift
//  File Manager App
//
//  Created by Arthur Raff on 29.04.2022.
//

import Foundation

typealias FullFilesData = ([(file: URL,
                            attributes: [FileAttributeKey: Any])]) -> Void

enum FileManagerDirectory {
    case documentDirectory
    
    var url: URL? {
        switch self {
        case .documentDirectory:
            return try? FileManager.default.url(for: .documentDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil,
                                                create: false)
        }
    }
}

protocol AppFileManager: AnyObject {
    func getFilesWithAttributes(atDirectory directory: FileManagerDirectory,
                                completion: FullFilesData)
    
    func create(file: Data,
                withName name: String,
                atDirectory directory: FileManagerDirectory)
    
    func removeFileOrDirectory(withName name: String,
                               atDirectory directory: FileManagerDirectory)
}
