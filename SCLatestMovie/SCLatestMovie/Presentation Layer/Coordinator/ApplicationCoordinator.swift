//
//  ApplicationCoordinator.swift
//  SCLatestMovie
//
//  Created by Suman Chatterjee on 19/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let navigationController: UINavigationController
    let rootViewCoordinator: MovieListCoordinator

    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewCoordinator = MovieListCoordinator(presenter: navigationController)
    }
    func start() {
        window.rootViewController = navigationController
        rootViewCoordinator.start()
        window.makeKeyAndVisible()
    }
}

