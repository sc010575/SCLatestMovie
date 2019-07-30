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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        viewModel.fetchMovies()
        viewModel.movies.bind { _ in
            self.title = "Latest movies"
            self.tableView.reloadData()
        }
        viewModel.state.bind { (state) in
            switch state {
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesCount()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reuseIdentifier, for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }

        if let movie = viewModel.movies.value[indexPath.row] as? MovieListViewModel.VMData {
            let rating = movie.userVote
            cell.configureCell(movie.title, rating: rating, releaseDate: movie.releaseDate, imageUrl: movie.posterPath)
        }
        return cell
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

