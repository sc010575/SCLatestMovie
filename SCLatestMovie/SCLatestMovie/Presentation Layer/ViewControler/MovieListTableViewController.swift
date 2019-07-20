//
//  ViewController.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    var viewModel: MovieListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        viewModel.fetchMovies()
    }
}

