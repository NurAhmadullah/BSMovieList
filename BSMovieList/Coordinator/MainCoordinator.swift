//
//  MainCoordinator.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let movieListVC = MovieListVC.instantiateFromStoryboard()
        self.navigationController.viewControllers = [movieListVC]
    }
}
