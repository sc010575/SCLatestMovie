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

    static let testFileUrl = "http://localhost:8088/3/movie/upcoming"
    static let ImageURL = "https://image.tmdb.org/t/p/w500"
    static var baseURL: String {
        
        if isUITest || isUnitTest {
            return "http://localhost:8088/3/movie"
        }
        
        return "https://api.themoviedb.org/3/movie"
    }
    
    static var movieURL: URL? {
        let url = "\(baseURL)/\(queryType)?api_key=\(apiKey)&\(language)"
        return  isUnderTest ? URL(string: Constant.testFileUrl) : URL(string: url)
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
