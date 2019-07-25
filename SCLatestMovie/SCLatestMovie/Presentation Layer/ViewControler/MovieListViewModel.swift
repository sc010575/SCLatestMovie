//
//  MovieListViewModel.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 20/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

protocol MovieListViewModelCoordinatorDelegate: class
{
    func MovieListViewModelDidSelect(_ viewModel: MovieListViewModel, data: Movie)
}


protocol MovieListViewModelProtocol: class {

    var apiController: ApiControllerProtocol { get set }
    var movies: Observer<[Movie]> { get set }
    var state: Observer<State> { get set }

    var delegate: MovieListViewModelCoordinatorDelegate? { get set }

    func fetchMovies()
    func useItemAtIndex(_ index: Int)
    func moviesCount() -> Int
}

enum State {
    case noResults, failure(error: Error), dataError(error: String), notReachable(error: String), success
}

final class MovieListViewModel: NSObject , MovieListViewModelProtocol {

    var apiController: ApiControllerProtocol
    var movies: Observer<[Movie]> = Observer([])
    var state: Observer<State> = Observer(.noResults)
    weak var delegate: MovieListViewModelCoordinatorDelegate?

    init(_ apiController: ApiControllerProtocol = ApiController()) {
        self.apiController = apiController
    }

    //MARK:- Public methods
    func fetchMovies() {
        //Test reachability first 
        guard currentReachabilityStatus != .notReachable else {
           return  self.state.value = .notReachable(error: "Not connected to the network")
        }

        
        apiController.latestMovies(.date, onSuccess: { (movieList) in
            self.movies.value = movieList.results
        }, onFailure: { (apiError) in
                switch apiError {
                case .dataError(let errorMessage):
                    self.state.value = .dataError(error: errorMessage)
                case .networkError(let error):
                    self.state.value = .failure(error: error)

                }
            })
        }

        func moviesCount() -> Int {
            return movies.value.count
        }

        func useItemAtIndex(_ index: Int)
        {
            if let delegate = delegate {
                let movie = movies.value[index]
                delegate.MovieListViewModelDidSelect(self, data: movie)
            }
        }
    }
