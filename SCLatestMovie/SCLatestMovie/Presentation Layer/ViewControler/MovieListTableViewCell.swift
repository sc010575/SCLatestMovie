//
//  MovieListTableViewCell.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 20/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!

    //MARK:- Static function
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    //MARK:- Configure cell
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(_ title: String, rating: String, releaseDate: String?, imageUrl: String?) {
        titleLabel.text = title
        voteCountLabel.text = "Rating: \(rating)"
        if let releaseDate = releaseDate {
            releaseDateLabel.text = releaseDate
        } else {
            releaseDateLabel.text = "Release date not specified"
        }
        guard let url = URL(string: Constant.ImageURL + (imageUrl ?? "")) else { return }
        iconImageView.sd_setImage(with: url, completed: nil)
    }
}
