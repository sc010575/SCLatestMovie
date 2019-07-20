//
//  Movie.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

class MovieList: Decodable {
    let results: [Movie]
}

class Movie: Decodable {
    let title: String
    let overview: String
    let posterPath: String
    let voteAverage: Double
    let popularity: Double
    let releaseDate : String
}
