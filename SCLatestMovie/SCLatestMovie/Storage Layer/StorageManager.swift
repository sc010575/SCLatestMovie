//
//  StorageManager.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 27/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

class StorageManager {
    // get document directory
    static fileprivate func getDocumentDirectory() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Unable to create document directory")
        }
    }

    // Save object in the disk
    static func save<T:Encodable>(_ object:T, with fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        }catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Load object from the disk
    static func load<T:Decodable> (_ fileName:String, with type:T.Type) ->T {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path){
            fatalError("File not found at path: \(url.path)")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(type, from: data)
                return model
            }catch {
                fatalError(error.localizedDescription)
            }
        }else{
            fatalError("Data not availabe in the file path \(url.path)")
        }
    }
    
}
