//
//  ViewController.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    var viewModel: MovieListViewModelProtocol!
    var dataSource: MovieListDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
        viewModel.fetchMovies()

        viewModel.state.bind { (state) in
            switch state {
            case .success:
                self.title = "Latest movies"
                self.tableView.reloadData()
            case .failure(let error):
                self.errorWithMessage(message: error.localizedDescription)
            case .notReachable(let result):
                self.errorWithMessage(message: result)
            case .dataError(let dataError):
                self.errorWithMessage(message: dataError)
            default:
                break
            }
        }
    }

    //MARK:- tableView delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.useItemAtIndex(indexPath.row)
    }

    //MARK:- Error message

    func errorWithMessage(message: String) {

        let alert = UIAlertController(title: "Service Error", message: message, preferredStyle: .alert)
        let retry = UIAlertAction(title: "Retry", style: .default, handler: { (alert: UIAlertAction!) in
            self.viewModel.fetchMovies()
        }
        )
        alert.addAction(retry)
        self.present(alert, animated: true, completion: nil)

    }
}

