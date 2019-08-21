//
//  ApiController.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

//MARK:- ApiControllerProtocol

enum ErrorCase {
    case dataError (errorMessage: String)
    case networkError (error: Error)
}

enum SortBy {
    case date
    case userVote
}

protocol ControlerFailureReturnType {
    typealias Failure = ((ErrorCase) -> ())?
}

protocol ApiControllerProtocol: ControlerFailureReturnType {
    typealias Success = (Data) -> Void
    func loadData(with url: URL, onSuccess: @escaping Success, onFailure: Failure)
}

//MARK:- Final class for ApiController
final class ApiController: NSObject, ApiControllerProtocol {
    func loadData(with url: URL, onSuccess: @escaping Success, onFailure: Failure) {
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
                            return onSuccess(data)
                    }
                } else {
                    DispatchQueue.main.async {
                        guard let onFailure = onFailure else { return }
                        return onFailure(.dataError(errorMessage: "Data error"))
                        
                    }
                }
            }
        })
        task.resume()
    }
}

protocol MovieListUseCaseProtocol: ControlerFailureReturnType {
//    var apiController : ApiControllerProtocol { get set }
    typealias Success = (MovieList) -> Void
    // To make init in protocol extension work
// init()
    init(_ controller:ApiControllerProtocol)
    func latestMovies(_ sortBy: SortBy, onSuccess: @escaping Success, onFailure: Failure)
}

//extension MovieListUseCaseProtocol {
//    private let apiCon
//    init(_ controller:ApiControllerProtocol) {
//        self.init()
//        self.apiController = controller
//    }
//}

final class MovieListUseCase: MovieListUseCaseProtocol {
    
    private var apiController: ApiControllerProtocol
    required init(_ controller: ApiControllerProtocol = ApiController()) {
        self.apiController = controller
    }
    
    func latestMovies(_ sortBy: SortBy, onSuccess: @escaping Success, onFailure: Failure) {
        guard let url = Constant.movieURL else { return }

        apiController.loadData(with: url, onSuccess: { data in
            if let movies: MovieList = ParseJson.parse(data: data) {
               return onSuccess(movies.sortBy(sortBy))
            }else{
                onFailure?(.dataError(errorMessage: "Parsing error"))
            }
        }, onFailure: { error in
            onFailure?(error)
        })
    }
}
