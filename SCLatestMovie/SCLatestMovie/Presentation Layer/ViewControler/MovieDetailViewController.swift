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
    
    var movie: Movie!

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var popularityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        self.overviewLabel .text = movie.overview
        self.title = movie.title
        self.popularityLabel.text = "Like: \(Int(movie.popularity ?? 0 ))👌"
        guard let url = URL(string: Constant.ImageURL + movie.posterPath) else { return }
        self.posterImageView.sd_setImage(with: url, completed: nil)
    }
}
