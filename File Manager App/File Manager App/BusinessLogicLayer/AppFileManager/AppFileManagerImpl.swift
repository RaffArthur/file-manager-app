//
//  AppFileManagerImpl.swift
//  File Manager App
//
//  Created by Arthur Raff on 29.04.2022.
//

import Foundation

final class AppFileManagerImpl: AppFileManager {
    func getFilesWithAttributes(atDirectory directory: FileManagerDirectory,
                                completion: FullFilesData) {
        var convertedFullFilesData = [(file: URL,
                              attributes: [FileAttributeKey: Any])]()
        
        guard let directoryUrl = directory.url else { return }
        
        let files = try? FileManager.default.contentsOfDirectory(at: directoryUrl,
                                                                 includingPropertiesForKeys: nil,
                                                                 options: [.skipsHiddenFiles])
        
        files?.forEach {
            var attributes: [FileAttributeKey : Any] = [:]
            let fileUrl = directoryUrl.appendingPathComponent($0.lastPathComponent)
            let fileExist = FileManager.default.fileExists(atPath: fileUrl.path)
            
            if fileExist == true {
                guard let convertedAttributes = try? FileManager.default.attributesOfItem(atPath: fileUrl.path)
                else {
                    return
                }
                
                attributes = convertedAttributes
            }
            
            convertedFullFilesData.append((file: $0, attributes: attributes))
        }
        
        completion(convertedFullFilesData)
    }
    
    func create(file: Data,
                withName name: String,
                atDirectory directory: FileManagerDirectory) {
        guard let directoryUrl = directory.url else { return }
        
        let fileUrl = directoryUrl.appendingPathComponent(name)

        FileManager.default.createFile(atPath: fileUrl.path,
                                       contents: file)
    }
    
    func removeFileOrDirectory(withName name: String,
                               atDirectory directory: FileManagerDirectory) {
        guard let directoryUrl = directory.url else { return }
        
        let fileUrl = directoryUrl.appendingPathComponent(name)
        
        try? FileManager.default.removeItem(atPath: fileUrl.path)
    }
}
