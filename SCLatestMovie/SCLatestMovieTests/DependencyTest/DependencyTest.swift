//
//  DependencyTest.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 21/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble

@testable import SCLatestMovie

class DependencyTest: QuickSpec {
    override func spec() {
        describe("Dependency Injection on the list viewController test") {
            var viewControllerOnTest: MovieListTableViewController?
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let apicontroller: FakeApiController = FakeApiController()
            let viewmodel = FakeMovieListViewModel(apicontroller)

            context("When user initiate MovieListTableViewController") {
                beforeEach {
                    viewControllerOnTest = storyboard.instantiateViewController(withIdentifier: "MovieListTableViewController") as? MovieListTableViewController
                    viewControllerOnTest?.viewModel = viewmodel
                    viewControllerOnTest?.preloadView()
                    let (_, tearDown) = (viewControllerOnTest?.appearInWindowTearDown())!
                    do { tearDown() }


                }
                it("Should call fetchMovies to retrive movies") {

                    let viewModel = viewControllerOnTest?.viewModel as? FakeMovieListViewModel
                    expect(viewModel?.spyFetchMoviesCalled).to(beTrue())
                    expect(viewModel?.moviesCount()).to(equal(2))
                }
                it("Should called moviesCount") {
                    let viewModel = viewControllerOnTest?.viewModel as? FakeMovieListViewModel
                    expect(viewModel?.spyMoviesCountCalled).to(beTrue())
                }
            }
        }
    }
}
