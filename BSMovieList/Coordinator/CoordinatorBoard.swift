//
//  CoordinatorStoryboard.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import Foundation
import UIKit

protocol CoordinatorStoryboard: UIViewController {
    static func instantiateFromStoryboard() -> Self
}

extension CoordinatorStoryboard {
    static func instantiateFromStoryboard() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
