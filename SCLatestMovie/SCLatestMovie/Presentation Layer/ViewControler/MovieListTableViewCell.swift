//
//  MovieListTableViewCell.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 20/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit
import SDWebImage


protocol ItemViewModel {

}
struct MovieListCellViewModel: ItemViewModel {
    let title: String
    let rating: String
    let posterPath: String
    let releaseDate: String

    init(movie: Movie) {
        title = movie.title
        posterPath = movie.posterPath
        releaseDate = movie.releaseDate ?? "Release date not specified"
        rating = "Rating: \(movie.userVote(from: movie.voteAverage ?? 0))"
    }
}

protocol CellConfigurable {
    static var cellIdentifire: String { get }
    func configureCell(_ viewModel:ItemViewModel)
}

class MovieListTableViewCell: UITableViewCell,CellConfigurable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!

    
    //MARK:- Configure cell
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var cellIdentifire: String {
        return String(describing: self)
    }

    func configureCell(_ viewModel:ItemViewModel) {
        let viewModel = viewModel as? MovieListCellViewModel
        titleLabel.text = viewModel?.title
        voteCountLabel.text = viewModel?.rating
        releaseDateLabel.text = viewModel?.releaseDate

        guard let url = URL(string: Constant.ImageURL + (viewModel?.posterPath ?? "")) else { return }
        iconImageView.sd_setImage(with: url, completed: nil)
    }
}
