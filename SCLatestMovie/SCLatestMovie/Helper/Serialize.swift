//
//  Serialize.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

protocol Serialize {
    associatedtype model
    static func parse(data: Data) -> model?
}

final class ParseJson<T:Decodable>: Serialize {
    typealias model = T
    class func parse(data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
}
