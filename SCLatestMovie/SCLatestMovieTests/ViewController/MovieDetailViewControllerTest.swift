//
//  MovieDetailViewControllerTest.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 21/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble

@testable import SCLatestMovie

class MovieDetailViewControllerTest: QuickSpec {
    override func spec() {
        describe("MovieListTest Test") {
            var viewControllerOnTest: MovieDetailViewController?
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            context("when MovieDetailViewController loaded with a valid Movie model") {
                beforeEach {
                    let dataResult = Fixtures.getJSONData(jsonPath: "movilist")
                    let movieList: MovieList = ParseJson.parse(data: dataResult!)!

                    viewControllerOnTest = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
                    let movie = movieList.results[0]

                    let viewModel = MovieDetailViewModel(0)
                    viewModel.movieDetail = MovieDetailViewModel.VMData(title: movie.title, posterPath: movie.posterPath, overview: <#T##String#>, like: <#T##String#>, genre: <#T##String#>, movieType: <#T##String#>)
                    viewControllerOnTest?.preloadView()
                    let (_, tearDown) = (viewControllerOnTest?.appearInWindowTearDown())!
                    do { tearDown() }

                }

                it("should populate the title properly") {
                    expect(viewControllerOnTest?.title).to(equal("The Lion King"))
                }

                it("should have a valid poster url") {
                    expect(viewControllerOnTest?.movie.posterPath).to(equal("/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg"))
                }
                it("should have a vilid overview") {
                    expect(viewControllerOnTest?.overviewLabel.text).to(equal("Overview One"))
                }
                it("should have a valid like data") {
                    expect(viewControllerOnTest?.popularityLabel.text).to(equal("Like: 502👌"))
                }
                it("should have a valid movie type") {
                    expect(viewControllerOnTest?.movieTypeLabel.text).to(equal("Universal"))
                }
                it("should have a list of genres") {
                    expect(viewControllerOnTest?.genresLabel.text).to(equal("Adventure, Animation, Family, Drama, Action"))
                }
            }
        }
    }
}
