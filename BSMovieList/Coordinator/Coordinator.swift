//
//  Coordinator.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators:[Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    func start()
}
