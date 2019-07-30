//
//  FakeMovieListViewModel.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 21/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

@testable import SCLatestMovie

class FakeMovieListViewModel: MovieListViewModelProtocol {
    var state: Observer<State> = Observer(.noResults)
    
    
    var apiController: ApiControllerProtocol
    var movies: Observer<[VMDataItem]> = Observer([])
    var delegate: MovieListViewModelCoordinatorDelegate?
    var spyFetchMoviesCalled:Bool = false
    var spyUseItemAtIndexCalled = false
    var spyMoviesCountCalled = false
    
    init(_ apiController: ApiControllerProtocol) {
        self.apiController = apiController
        self.state.value = .success
    }

    func fetchMovies() {
        spyFetchMoviesCalled = true
        let movie1 = (title: "A title", userVote: "20", posterPath: "A PosterPath", releaseDate: "20/01/2019")
        let movie2 = (title: "A new title", userVote: "40", posterPath: "A new PosterPath", releaseDate: "30/11/2019")
        let movieList = [movie1, movie2]
        movies.value = movieList
    }
    
    func useItemAtIndex(_ index: Int) {
        spyUseItemAtIndexCalled = true
        
    }
    
    func moviesCount() -> Int {
        spyMoviesCountCalled = true
        return 2
    }

}
