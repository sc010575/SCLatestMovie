//
//  MovieDetailViewModel.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 28/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelProtocol: class {
    typealias VMData = (title: String, posterPath: String, overview: String, like: String, genre: String, movieType: String)
    var index: Int { get set }
    func loadMovie() -> VMData
}

extension MovieDetailViewModelProtocol {
    func returnEmptyData() -> VMData {
        let vmData:VMData = (title: "", posterPath: "", overview: "", like: "", genre: "", movieType: "")
        return vmData
    }
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {

    var index: Int

    init(_ index: Int) {
        self.index = index
    }

    func loadMovie() -> VMData {
        var movieList = MovieList(results: [])
        movieList = movieList.loadMovieList()
        let movie = movieList.results[index]
        var vmData: VMData = returnEmptyData()
        vmData.title = movie.title
        vmData.posterPath = movie.posterPath
        vmData.overview = movie.overview
        vmData.like = "Like: \(Int(movie.popularity ?? 0))👌"
        vmData.genre = movie.genresList()?.joined(separator: ", ") ?? ""
        vmData.movieType = movie.movieType()
        return vmData
    }

}
