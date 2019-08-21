//
//  FakeApiController.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 21/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

@testable import SCLatestMovie

class FakeApiController: ApiControllerProtocol {

    var spyApiControllerCalled = false
    var spyloadDataSuccess = false

    func loadData(with url: URL, onSuccess: @escaping Success, onFailure: Failure) {
        spyApiControllerCalled = true

    }
}

final class FakeMovieListUseCase: MovieListUseCaseProtocol {
    private let apiController: ApiControllerProtocol
    var spylatestMoviesCalled = false
    var spyOnLatestMovieSuccess = false
    var movies = MovieList(results: [])
    required init(_ controller: ApiControllerProtocol = FakeApiController()) {
        self.apiController = controller
    }

    func latestMovies(_ sortBy: SortBy, onSuccess: @escaping Success, onFailure: Failure) {
        spylatestMoviesCalled = true
        if spyOnLatestMovieSuccess {
            return onSuccess(movies.sortBy(sortBy))
        } else {
            return (onFailure?(.dataError(errorMessage: "error")))!
        }
    }
}

