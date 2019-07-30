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
    var movies: Observer<[Any]> = Observer([])
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
        let movie1 = Movie(title: "A title", overview: "A Overview", posterPath: "A PosterPath", voteAverage: 6, popularity: 234, releaseDate: "20/01/2019", adult: false, genreIds: [12,16], date: Date())
        let movie2 = Movie(title: "A new title", overview: "A new Overview", posterPath: "A new PosterPath", voteAverage: 2, popularity: 23, releaseDate: "30/11/2019", adult: true, genreIds: [18,28], date: nil)
        let movieList = MovieList(results: [movie1, movie2])
        movies.value = movieList.results
    }
    
    func useItemAtIndex(_ index: Int) {
        spyUseItemAtIndexCalled = true
        
    }
    
    func moviesCount() -> Int {
        spyMoviesCountCalled = true
        return 2
    }

}
