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

    enum Rating: Double {
        typealias RawValue = Double
        case verygood
        case good
        case average
        case poor
        case noRating

        func getRange(_ votingAverage: Double) -> Rating {
            switch votingAverage {
            case 8 ..< 11: return .verygood
            case 6 ..< 8: return .good
            case 4 ..< 6: return .average
            case 1 ..< 4: return .poor
            case 0: return .noRating
            default:
                break
            }
            return .noRating
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!

    var rating: Rating = .noRating

    //MARK:- Static function
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    //MARK:- Configure cell
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(_ title: String, voteCount: Double, releaseDate: String?, imageUrl: String?) {
        titleLabel.text = title
        let userReview = userVote(from: voteCount)
        voteCountLabel.text = "Rating: \(userReview)"
        if let releaseDate = releaseDate {
            releaseDateLabel.text = releaseDate
        } else {
            releaseDateLabel.text = "Release date not specified"
        }
        guard let url = URL(string: Constant.ImageURL + (imageUrl ?? "")) else { return }
        iconImageView.sd_setImage(with: url, completed: nil)
    }

    func userVote(from voteCount: Double) -> String {
        let userRating = rating.getRange(voteCount)
        switch userRating {
        case .verygood:
            return "Great Movie! 👍"
        case .good:
            return "Good Movie! ✋"
        case .average:
            return "Ok type 🤔 "
        case .poor:
            return "Poor. 👎"
        case .noRating:
            return "No rating 🙄"
        }
    }
}
