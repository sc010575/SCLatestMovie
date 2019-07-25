//
//  ApiController.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

//MARK:- ApiControllerProtocol

enum ApiError {
    case dataError (errorMessage: String)
    case networkError (error: Error)
}

enum SortBy {
    case date
    case userVote
}

protocol ApiControllerProtocol {
    typealias Success = (MovieList) -> Void
    typealias Failure = ((ApiError) -> Void)?

    func latestMovies(_ sortBy: SortBy,onSuccess: @escaping Success, onFailure: Failure)

}

//MARK:- Final class for ApiController

final class ApiController: NSObject, ApiControllerProtocol {

    func latestMovies(_ sortBy: SortBy, onSuccess: @escaping Success, onFailure: Failure) {


        guard let url = Constant.movieURL else { return }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            if error != nil, let error = error {
                DispatchQueue.main.async {
                    guard let onFailure = onFailure else { return }
                    onFailure(.networkError(error: error))
                }
                return
            } else {
                if let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200, let data = data {
                    DispatchQueue.main.async {
                        if let movies: MovieList = ParseJson.parse(data: data) {
                            var sortedMovies =  MovieList(results: [])
                            if sortBy == .userVote {
                                sortedMovies = movies.sortedResult()
                            } else {
                                sortedMovies = movies.sortByDate()
                            }
                            onSuccess(sortedMovies)
                            return
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        guard let onFailure = onFailure else { return }
                        onFailure(.dataError(errorMessage: "Data error"))
                        return
                    }
                }
            }
        })
        task.resume()
    }
}
