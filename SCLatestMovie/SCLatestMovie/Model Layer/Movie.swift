//
//  Movie.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

struct MovieList: Decodable {
    let results: [Movie]
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
    let releaseDate: String?
    let adult: Bool
    let genreIds: [Int]?

    static let emptyMovie = Movie(title: "", overview: "", posterPath: "", voteAverage: 0.0, popularity: 0.0, releaseDate: "", adult: false, genreIds: [])

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
