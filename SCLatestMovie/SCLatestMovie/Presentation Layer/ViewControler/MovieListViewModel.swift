//
//  MovieListViewModel.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 20/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation



protocol MovieListViewModelProtocol: class {

    var apiController: ApiController { get set }
    var movies: Observer<[Movie]> { get set }
    func fetchMovies()
}

class MovieListViewModel: MovieListViewModelProtocol {

    var apiController: ApiController
    var movies: Observer<[Movie]> = Observer([])

    init(_ apiController: ApiController) {
        self.apiController = apiController
    }

    //MARK:- Public methods
    func fetchMovies() {
        apiController.latestMovies(onSuccess: { (movieList) in
            print(movieList.results[0].overview)
            self.movies.value = movieList.results
        }, onFailure: { (error) in
                print(error.localizedDescription)
            }, onNotReachable: { (result) in
                print(result)
            }) { (dataError) in
            print(dataError)
        }
    }
    
    func moviesCount()-> Int {
        return movies.value.count
    }
}
