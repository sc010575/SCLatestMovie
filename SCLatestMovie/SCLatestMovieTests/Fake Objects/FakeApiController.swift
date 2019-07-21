//
//  FakeApiController.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 21/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

@testable import SCLatestMovie

class FakeApiController : ApiControllerProtocol {
    
    var spyLatestMoviesCalled = false
    
    func latestMovies(onSuccess: @escaping FakeApiController.Success, onFailure: Failure, onNotReachable: FakeApiController.NotReachable, onDataError: FakeApiController.DataError) {
        spyLatestMoviesCalled = true
    }
    
    
}
