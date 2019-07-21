//
//  MockServer.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 21/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import GCDWebServer

class MockServer {
    var server = GCDWebServer()
    
    func start() {
        do {
            try server.start(options: [
                GCDWebServerOption_BindToLocalhost: true,
                GCDWebServerOption_Port: 8088,
                GCDWebServerOption_AutomaticallySuspendInBackground: false,
                ])
        } catch let exception {
            print(exception.localizedDescription)
        }
    }
    
    func stop() {
        if server.isRunning {
            server.stop()
        }
        
        server.removeAllHandlers()
    }
    
    @discardableResult
    func respondToLatestMovies(fixture: String = "movielistresponse", statusCode: Int = 200)  -> MockServer {
        let responseData = dataFromFixture(fixture)
        
        addResponse(method: "GET", path: "/3/movie/upcoming", responseData: responseData!, statusCode: statusCode)
        
        return self
    }
    
    @discardableResult
    func respondToLatestMoviesWithError(fixture: String = "errorresponse", statusCode: Int = 404)  -> MockServer {
        let responseData = dataFromFixture(fixture)

        addResponse(method: "GET", path: "/3/movie/upcoming", responseData: responseData!, statusCode: statusCode)

        return self
    }
}


private extension MockServer {
    
    func addResponse(method: String = "GET", path: String = "/", responseData: Data, statusCode: Int = 200) {
        server.addHandler(forMethod: method, path: path, request: GCDWebServerRequest.self) { request in
            print(request.url.absoluteString)
            let response = GCDWebServerDataResponse(data: responseData, contentType: "application/json")
            response.statusCode = statusCode
            return response
        }
    }
    
    func dataFromFixture(_ fixture: String) -> Data? {
        guard let responseData: Data = Fixtures.getJSONData(jsonPath: fixture) else {
            print("INVALID FIXTURE: \(fixture)")
            return nil
        }
        
        return responseData
    }
}
