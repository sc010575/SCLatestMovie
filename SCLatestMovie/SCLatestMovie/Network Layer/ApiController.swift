//
//  ApiController.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

class ApiController: NSObject {

    typealias Success = (MovieList) -> Void
    typealias Failure = (Error) -> Void
    typealias NotReachable = (String) -> Void
    typealias DataError = (String) -> Void

    func latestMovies(onSuccess: @escaping Success, onFailure: @escaping Failure, onNotReachable: NotReachable, onDataError: @escaping DataError) {

        guard currentReachabilityStatus != .notReachable else {
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
                    onFailure(error)
                }
                return
            } else {
                if let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200, let data = data {
                    DispatchQueue.main.async {
                        if let movies: MovieList = ParseJson.parse(data: data) {
                            onSuccess(movies)
                            return
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        onDataError("Data error")
                        return
                    }
                }
            }
        })
        task.resume()
    }
}
