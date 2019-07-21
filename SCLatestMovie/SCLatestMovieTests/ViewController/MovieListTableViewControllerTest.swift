//
//  MovieListTableViewControllerTest.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 21/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import SCLatestMovie

class MovieListTableViewControllerTest: QuickSpec {
    let server = MockServer()
    override func spec() {
        describe("MovieListTableViewController Test") {
            var viewControllerOnTest: MovieListTableViewController?
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            context("When MovieListTableViewController loadedd with a successfull response") {
                beforeEach {
                    viewControllerOnTest = storyboard.instantiateViewController(withIdentifier: "MovieListTableViewController") as? MovieListTableViewController
                    self.server.respondToLatestMovies().start()
                    let apiController = ApiController()
                    let viewModel = MovieListViewModel(apiController)
                    viewControllerOnTest?.viewModel = viewModel
                    viewControllerOnTest?.preloadView()
                    let (_, tearDown) = (viewControllerOnTest?.appearInWindowTearDown())!
                    do { tearDown() }
                    
                }
                
                afterEach {
                    self.server.stop()
                }
                it("Should load a valid title if the request successful") {
                    expect(viewControllerOnTest?.title).toEventually(equal("Latest movies"))
                }
                it("Should have valid movie list") {
                    expect(viewControllerOnTest?.tableView.numberOfRows(inSection: 0)).toEventually(equal(20))
                }
                it("should have proper value for each row") {
                    let cell = viewControllerOnTest?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MovieListTableViewCell
                    guard let title = cell?.titleLabel.text else {
                        return XCTAssert(true)
                    }
                    expect(title).toEventually(equal("The Lion King"))
                }
                
            }
        }
    }
}
