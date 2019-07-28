//
//  MovieDetailViewModel.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 28/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

class MovieDetailViewModel {

    struct vmData {
        let title:String
        let posterPath: String
        let overview: String
        let like: Int
        let genre: String
        let movieType: String
    }

    var movieDetail: Observer<vmData> = Observer(vmData(title:"", posterPath: "", overview: "", like: 0, genre: "", movieType: ""))

    init(_ index:Int) {
        self.loadMovie(with: index)
    }
    
    func loadMovie(with index:Int) {
        var movieList = MovieList(results: [])
        movieList = movieList.loadMovieList()
        let movie = movieList.results[index]

        movieDetail.value = vmData(title:movie.title, posterPath: movie.posterPath, overview: movie.overview, like: Int(movie.popularity ?? 0), genre: movie.genresList()?.joined(separator: ", ") ?? "", movieType: movie.movieType())

    }

}
