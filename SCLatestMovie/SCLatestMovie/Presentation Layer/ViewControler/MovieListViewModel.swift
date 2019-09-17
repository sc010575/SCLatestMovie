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
    func MovieListViewModelDidSelect(_ viewModel: MovieListViewModel, on index: Int)
}



protocol MovieListViewModelProtocol: class {
    var state: Observer<State> { get set }
    var delegate: MovieListViewModelCoordinatorDelegate? { get set }

    func fetchMovies()
    func useItemAtIndex(_ index: Int)
    func moviesCount() -> Int
    func movieAtIndex(_ index: Int) ->MovieListCellViewModel
}

extension MovieListViewModelProtocol {
    func resultItem(for movie: Movie) -> MovieListCellViewModel {
        let vmCellData = MovieListCellViewModel(movie:movie)
        return vmCellData
    }
}

enum State {
    case noResults, failure(error: Error), dataError(error: String), notReachable(error: String), success
}

final class MovieListViewModel: NSObject, MovieListViewModelProtocol {
    private (set) var movieListController: MovieListUseCaseProtocol
    private var movies = [MovieListCellViewModel]()

    var state: Observer<State> = Observer(.noResults)
    weak var delegate: MovieListViewModelCoordinatorDelegate?

    init(_ controller: MovieListUseCaseProtocol = MovieListUseCase()) {
        self.movieListController = controller
    }

    //MARK:- Public methods
    func fetchMovies() {
        //Test reachability first
        guard currentReachabilityStatus != .notReachable else {
            return self.state.value = .notReachable(error: "Not connected to the network")
        }
        movieListController.latestMovies(.date, onSuccess: { (movieList) in
            self.prepareViewModelData(movieList)
            self.state.value = .success
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
        return movies.count
    }

    func useItemAtIndex(_ index: Int)
    {
        if let delegate = delegate {
            delegate.MovieListViewModelDidSelect(self, on: index)
        }
    }
    
    func movieAtIndex(_ index: Int) -> MovieListCellViewModel {
        return movies[index]
    }
    
}

private extension MovieListViewModel {
    func prepareViewModelData(_ movieList: MovieList) {
        movieList.saveMovieList()
        movies = movieList.results.map {
            return resultItem(for: $0)
        }
    }
}
