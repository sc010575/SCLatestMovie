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
    
    func movieAtIndex(_ index: Int) -> MovieListCellViewModel {
        return movies[index]
    }
    
    var state: Observer<State> = Observer(.noResults)
    
    
    var apiController: ApiControllerProtocol
    var movies = [MovieListCellViewModel]()
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
        let movie1 = Movie(title: "A title", overview: "A Overview", posterPath: "A path", voteAverage: 90, popularity: 100, releaseDate: "20/01/2019", adult: false, genreIds: [], date: nil)
        
        let movie2 = Movie(title: "A title 2", overview: "A Overview 2", posterPath: "A path 2", voteAverage: 70, popularity: 100, releaseDate: "20/09/2019", adult: true, genreIds: [], date: nil)
        
        let movieList:MovieList = MovieList(results: [movie1, movie2])
        movies = movieList.results.map {
            return resultItem(for: $0)
        }
    }
    
    func useItemAtIndex(_ index: Int) {
        spyUseItemAtIndexCalled = true
    }
    
    func moviesCount() -> Int {
        spyMoviesCountCalled = true
        return 2
    }

}
