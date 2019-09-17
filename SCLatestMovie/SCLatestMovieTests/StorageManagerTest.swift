//
//  StorageManagerTest.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 30/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble

@testable import SCLatestMovie

class StorageManagerTest: QuickSpec {
    override func spec() {
        describe("StorageManager Test") {
            context("When storage manager is initiated") {
                it("should load a right movielist object") {
                    let dataResult = Fixtures.getJSONData(jsonPath: "movilist")
                    let movieList: MovieList = ParseJson.parse(data: dataResult!)!
                    StorageManager.save(movieList, with: "testFile")
                    let resultMovieList = StorageManager.load("testFile", with: MovieList.self)
                    expect(resultMovieList.results.count).to(equal(2))
                    expect(resultMovieList.results[0].title).to(equal("The Lion King"))
                }
            }
        }
    }
}
