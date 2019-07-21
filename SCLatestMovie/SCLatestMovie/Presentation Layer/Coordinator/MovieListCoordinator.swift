//
//  MovieListCoordinator.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 20/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

class MovieListCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var movieDetailCoordinator: MovieDetailCoordinator!
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.movieDetailCoordinator = MovieDetailCoordinator(presenter: presenter)
    }
    
    func start() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootViewController = storyBoard.instantiateViewController(withIdentifier: "MovieListTableViewController") as? MovieListTableViewController else { return }
        rootViewController.title = "Loading..."
        let viewModel = MovieListViewModel()
        viewModel.delegate = self
        rootViewController.viewModel = viewModel
        presenter.pushViewController(rootViewController, animated: true)
    }
}

extension MovieListCoordinator: MovieListViewModelCoordinatorDelegate {
    func MovieListViewModelDidSelect(_ viewModel: MovieListViewModel, data: Movie) {
        movieDetailCoordinator.movie = data
        movieDetailCoordinator.start()
    }
}
