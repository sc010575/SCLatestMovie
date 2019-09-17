//
//  FakeMovieDetailViewModel.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 30/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

@testable import SCLatestMovie

class FakeMovieDetailViewModel: MovieDetailViewModelProtocol {
    var index: Int = 0
    
    func loadMovie() -> VMData {
        var vmData = emptyVMData()
        vmData.movieType = "Adult"
        vmData.genre = "Adventure, Animation, Family, Drama, Action"
        vmData.like = "Like: 290👌"
        vmData.title = "A Title"
        vmData.overview = "A overview"
        vmData.posterPath = "A poster path"
        return vmData
    }
}
