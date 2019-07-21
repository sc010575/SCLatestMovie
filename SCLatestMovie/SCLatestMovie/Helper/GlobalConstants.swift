//
//  GlobalConstants.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

//For simplicity consider  a static dictonary, Ideally it should be a API call
let genreDict = [28:"Action", 12:"Adventure", 16:"Animation", 35:"Comedy", 80:"Crime", 99:"Documentory", 18:"Drama", 10751:"Family", 14:"Fantasy", 36:"History", 27:"Horror", 10402:"Music", 9648:"Mystery", 10749:"Romance", 878:"Science Fiction", 10770:"TV Movie", 53:"Thriller", 10752:"War", 37:"Western"]

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
