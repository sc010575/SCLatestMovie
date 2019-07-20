//
//  Fixture.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 20/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

class Fixtures: NSObject {
    static func getJSON(jsonPath: String) -> String? {
        guard let data = getJSONData(jsonPath: jsonPath) as Data? else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    static func getJSONData(jsonPath: String) -> Data? {
        return getData(filePath: jsonPath, ofType: "json")
    }
            
    static func getData(filePath: String, ofType: String) -> Data? {
        guard let path = Bundle(for: Fixtures.self).path(forResource: filePath, ofType: ofType),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                NSLog("************* No Fixture found with name '\(filePath).\(ofType)', did you add it to the fixtures? *************")
                return nil
        }
        
        return data
    }
}
