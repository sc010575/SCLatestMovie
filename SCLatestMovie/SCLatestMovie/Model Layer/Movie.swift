//
//  Movie.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

struct MovieList: Decodable {
    var results: [Movie]

    func sortedResult() -> MovieList {
        var movieList = MovieList(results: [])
        let r = results.sorted { (m1, m2) -> Bool in
            return Unicode.CanonicalCombiningClass(rawValue: UInt8(m1.voteAverage ?? 0.0)) > Unicode.CanonicalCombiningClass(rawValue: UInt8(m2.voteAverage ?? 0.0))
        }
        movieList.results = r
        return movieList
    }
    func sortByDate() -> MovieList {
        var movieList = MovieList(results: [])

        results.forEach { (movie) in
            var m = movie
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let releaseDate = m.releaseDate {
                let date = dateFormatter.date(from: releaseDate)
                m.date = date
                movieList.results.append(m)
            }

        }

        movieList.results = movieList.results.sorted (by: {
            return $0.date?.compare($1.date ?? Date()) == .orderedDescending
        })
        return movieList
    }
}

struct Movie: Decodable {

    enum Rating: Double {
        typealias RawValue = Double
        case verygood
        case good
        case average
        case poor
        case noRating

        static func getRange(_ votingAverage: Double) -> Rating {
            switch votingAverage {
            case 8 ..< 11: return .verygood
            case 6 ..< 8: return .good
            case 4 ..< 6: return .average
            case 1 ..< 4: return .poor
            case 0: return .noRating
            default:
                break
            }
            return .noRating
        }
    }


    let title: String
    let overview: String
    let posterPath: String
    let voteAverage: Double?
    let popularity: Double?
    var releaseDate: String?
    let adult: Bool
    let genreIds: [Int]?
    var date: Date?

    static let emptyMovie = Movie(title: "", overview: "", posterPath: "", voteAverage: 0.0, popularity: 0.0, releaseDate: "", adult: false, genreIds: [], date: Date())

    func movieType() -> String {
        return adult ? "Adult" : "Universal"
    }

    func userVote(from voteCount: Double) -> String {
        let userRating = Rating.getRange(voteCount)
        switch userRating {
        case .verygood:
            return "Great Movie! 👍"
        case .good:
            return "Good Movie! ✋"
        case .average:
            return "Ok type 🤔 "
        case .poor:
            return "Poor. 👎"
        case .noRating:
            return "No rating 🙄"
        }
    }

    func genresList() -> [String]? {

        var result = [String]()
        let genreIds = self.genreIds
        let gd = genreDict
        genreIds?.forEach({ id in
            if gd.keys.contains(id) {
                result.append(gd[id] ?? "")
            }
        })

        return result
    }
}
