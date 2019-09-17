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
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!

    var viewModel:MovieDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    fileprivate func setupView() {
        let vmData = viewModel.loadMovie()
        self.overviewLabel.text = vmData.overview
        self.title = vmData.title
        self.popularityLabel.text = vmData.like
        self.movieTypeLabel.text = vmData.movieType
        self.genresLabel.text = vmData.genre
        guard let url = URL(string: Constant.ImageURL + vmData.posterPath) else { return }
        self.posterImageView.sd_setImage(with: url, completed: nil)
    }
}
