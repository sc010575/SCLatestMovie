//
//  ApiControllerTest.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 21/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble

@testable import SCLatestMovie

class ApiControllerTest: QuickSpec {
    var server: MockServer!
    var apiController = ApiController()

    override func spec() {
        describe("ApiControllerTest Test") {
            beforeEach {
                self.server = MockServer()
            }

            afterEach {
                self.server.stop()
            }
            context("when ApiControler is call with a valid request") {
                it("should retrive a valid response and create a valid movie object when sort by date") {
                    self.server.respondToLatestMovies().start()
                    let downloadExpectiation = self.expectation(description: "Network service for movie list")

                    self.apiController.latestMovies(.date, onSuccess: { (movieList) in
                        expect(movieList.results.count).to(equal(20))
                        expect(movieList.results[1].popularity).to(equal(28.149))
                        downloadExpectiation.fulfill()
                    }, onFailure: { _ in
                        print("failure")
                    })

                    self.waitForExpectations(timeout: 10) { (error) in

                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }
                it("should retrive a valid response and create a valid movie object when sort by userVote") {
                    self.server.respondToLatestMovies().start()
                    let downloadExpectiation = self.expectation(description: "Network service for movie list")
                    
                    self.apiController.latestMovies(.userVote, onSuccess: { (movieList) in
                        expect(movieList.results.count).to(equal(20))
                        expect(movieList.results[1].popularity).to(equal(141.537))
                        downloadExpectiation.fulfill()
                    }, onFailure: { _ in
                        print("failure")
                    })
                    
                    self.waitForExpectations(timeout: 10) { (error) in
                        
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }

            }
            context("when Apicontroller is call with wrong request") {
                it("returns a failure") {
                    self.server.respondToLatestMoviesWithError().start()
                    let downloadExpectiation = self.expectation(description: "Network service for movie list")

                    self.apiController.latestMovies(.date, onSuccess: { _ in
                        
                    }, onFailure: { err in
                        switch err {
                        case .dataError(let error):
                            expect(error).to(equal("Data error"))
                        default:
                            break
                        }
                        downloadExpectiation.fulfill()
                    })
                    self.waitForExpectations(timeout: 10) { (error) in
                        
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}
