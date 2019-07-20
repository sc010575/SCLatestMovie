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
    private var rootViewController: MovieListTableViewController?
    
  //  weak var delegate: RootViewModelCoordinatorDelegate?
  //  private var rootDetailCoordinator: RootDetailCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
 //       rootDetailCoordinator = RootDetailCoordinator(presenter: presenter)
    }
    
    func start() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootViewController = storyBoard.instantiateViewController(withIdentifier: "MovieListTableViewController") as? MovieListTableViewController else { return }
        rootViewController.title = "Loading..."
        let apiController = ApiController()
        let viewModel = MovieListViewModel(apiController)
//        viewModel.coordinatorDelegate = self
        rootViewController.viewModel = viewModel
        presenter.pushViewController(rootViewController, animated: true)
        self.rootViewController = rootViewController
    }
}
