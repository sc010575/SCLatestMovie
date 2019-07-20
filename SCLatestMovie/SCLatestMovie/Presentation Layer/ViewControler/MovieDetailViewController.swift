//
//  MovieDetailViewController.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 20/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.movie.bind { [weak self] (movie) in
            self?.overviewLabel .text = movie.overview
            self?.title = movie.title
            guard let url = URL(string: Constant.ImageURL + movie.posterPath) else { return }

            self?.posterImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
