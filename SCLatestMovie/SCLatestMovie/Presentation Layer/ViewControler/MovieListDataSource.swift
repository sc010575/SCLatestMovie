//
//  MovieListDataSource.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 06/08/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class MovieListDataSource: NSObject, UITableViewDataSource {
    
    private var model: MovieListViewModelProtocol!
    
    init(_ viewModel:MovieListViewModelProtocol) {
        super.init()
        self.model = viewModel
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.moviesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.cellIdentifire, for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = model.movieAtIndex(indexPath.row)
        cell.configureCell(movie)
        return cell

    }
    
}
