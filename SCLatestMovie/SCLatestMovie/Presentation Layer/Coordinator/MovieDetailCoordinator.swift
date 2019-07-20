//
//  MovieDetailCoordinator.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 20/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailCoordinator: Coordinator {

    var movie: Movie?
    private let presenter: UINavigationController

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            let viewModel = MovieDetailViewModel()
            guard let movie = movie else { return }
            
            viewModel.movie.value = movie
            vc.viewModel = viewModel
            presenter.pushViewController(vc, animated: true)
        }
    }
}