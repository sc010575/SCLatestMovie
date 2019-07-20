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
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    //MARK:- Static function
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    //MARK:- Configure cell
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ title:String, popularity:Double, imageUrl:String?) {
        titleLabel.text = title
        popularityLabel.text = "\(popularity)"
        
        guard let url = URL(string: Constant.ImageURL + (imageUrl ?? "") ) else { return }
        iconImageView.sd_setImage(with: url, completed: nil)

    }
}
