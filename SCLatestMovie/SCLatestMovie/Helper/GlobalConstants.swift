//
//  GlobalConstants.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

enum Constant {
    static let apiKey = "449d682523802e0ca4f8b06d8dcf629c"
    static let queryType = "upcoming"
    static let language = "language=en"

  //  static let testFileUrl = "http://localhost:8088/sc010575/feb733f8c6d6c38b9db4208fb7791567"
    static let ImageURL = "https://image.tmdb.org/t/p/w500"
    static var baseURL: String {
        
        if isUITest || isUnitTest {
            return "https://localhost:8088"
        }
        
        return "https://api.themoviedb.org/3/movie"
    }
    
    static var movieURL: URL? {
        let url = "\(baseURL)/\(queryType)?api_key=\(apiKey)&\(language)"
        return URL(string: url)
    }
    

    
    static var isUnitTest: Bool {
        #if targetEnvironment(simulator)
        if let _ = NSClassFromString("XCTest") {
            return true
        }
        #endif
        return false
    }
    
    static var isUITest: Bool {
        #if targetEnvironment(simulator)
        if ProcessInfo.processInfo.environment["IsLocalServerBackend"] == "true" {
            return true
        }
        #endif
        return false
    }
    
    static var isUnderTest: Bool {
        return isUITest || isUnitTest ? true : false
    }
    
    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
}
