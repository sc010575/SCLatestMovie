//
//  MovieListTest.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 20/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble

@testable import SCLatestMovie

class MovieListTest: QuickSpec {
    override func spec() {
        describe("MovieListTest Test") {
            context("when valid data for Movie model") {
                it("should parse and load the model properly") {
                    let dataResult = Fixtures.getJSONData(jsonPath: "movilist")
                    if let modelUnderTest: MovieList = ParseJson.parse(data: dataResult!) {
                        expect(modelUnderTest.results[0].title).to(equal("The Lion King"))
                        expect(modelUnderTest.results[0].overview).to(equal("Overview One"))
                        expect(modelUnderTest.results[0].posterPath).to(equal("/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg"))
                        expect(modelUnderTest.results[0].releaseDate).to(equal("2019-07-12"))
                        expect(modelUnderTest.results.count).to(equal(2))
                    }
                }
            }
            context("when an invalid data for Movie model") {
                it("should not parse and send nil") {
                    let dataResult = Fixtures.getJSONData(jsonPath: "empty")
                    let modelUnderTest: MovieList? = ParseJson.parse(data: dataResult!)
                    expect(modelUnderTest).to(beNil())
                }
            }
            context("When user retrive and parse a proper response") {
                it("Should show proper rating information") {
                    let dataResult = Fixtures.getJSONData(jsonPath: "movilist")
                    if let modelUnderTest: MovieList = ParseJson.parse(data: dataResult!) {
                        let movie = modelUnderTest.results[0]
                        let rating = movie.userVote(from: movie.voteAverage ?? 0.0)
                        expect(rating).to(equal("Good Movie! ✋"))
                    }
                }
            }
        }
    }
}
