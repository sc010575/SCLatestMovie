//
//  ApiController.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

//MARK:- ApiControllerProtocol

protocol ApiControllerProtocol {
    typealias Success = (MovieList) -> Void
    typealias Failure = ((Error) -> Void)?
    typealias NotReachable = ((String) -> Void)?
    typealias DataError = ((String) -> Void)?

    func latestMovies(onSuccess: @escaping Success, onFailure: Failure, onNotReachable: NotReachable, onDataError: DataError)

}

//MARK:- Final class for ApiController

final class ApiController: NSObject, ApiControllerProtocol {

    func latestMovies(onSuccess: @escaping Success, onFailure: Failure = nil, onNotReachable: NotReachable = nil, onDataError: DataError = nil) {

        guard currentReachabilityStatus != .notReachable else {
            guard let onNotReachable = onNotReachable else { return }
            onNotReachable("Not connected to the network")
            return
        }

        guard let url = Constant.movieURL else { return }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            if error != nil, let error = error {
                DispatchQueue.main.async {
                    guard let onFailure = onFailure else { return }
                    onFailure(error)
                }
                return
            } else {
                if let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200, let data = data {
                    DispatchQueue.main.async {
                        if let movies: MovieList = ParseJson.parse(data: data) {
                         //   let sortedMovies = movies.sortedResult()
                            let sortMovies = movies.sortByDate()
                            onSuccess(sortMovies)
                            return
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        guard let onDataError = onDataError else { return }
                        onDataError("Data error")
                        return
                    }
                }
            }
        })
        task.resume()
    }
}
