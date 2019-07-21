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
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    fileprivate func setupView() {
        overviewLabel .text = movie.overview
        title = movie.title
        popularityLabel.text = "Like: \(Int(movie.popularity ?? 0))👌"
        movieTypeLabel.text = movie.movieType()
        let genresText = movie.genresList()?.joined(separator: ", ")
        genresLabel.text = genresText
        guard let url = URL(string: Constant.ImageURL + movie.posterPath) else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
