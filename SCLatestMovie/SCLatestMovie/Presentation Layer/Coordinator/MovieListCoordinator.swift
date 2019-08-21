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
    private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
      guard let rootViewController = storyBoard.instantiateViewController(withIdentifier: "MovieListTableViewController") as? MovieListTableViewController else { return }
        rootViewController.title = "Loading..."
        let viewModel = MovieListViewModel()
        viewModel.delegate = self
        let dataSource = MovieListDataSource(viewModel)
        rootViewController.dataSource = dataSource
        rootViewController.viewModel = viewModel
        presenter.pushViewController(rootViewController, animated: true)
    }
}

extension MovieListCoordinator: MovieListViewModelCoordinatorDelegate {
    func MovieListViewModelDidSelect(_ viewModel: MovieListViewModel, on index: Int) {
        if let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            let viewModel = MovieDetailViewModel(index)
            vc.viewModel = viewModel
            presenter.pushViewController(vc, animated: true)
        }
    }
}
