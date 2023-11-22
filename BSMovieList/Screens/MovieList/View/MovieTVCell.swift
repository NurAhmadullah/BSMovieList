//
//  MovieTVCell.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import UIKit

class MovieTVCell: UITableViewCell {
    
    static let identifier = "MovieTVCell"
    static let nib = UINib(nibName: "MovieTVCell", bundle: nil)
    
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: Movie){
        self.lblMovieTitle.text = model.originalTitle
        self.lblMovieDescription.text = model.overview
        ApiService.shared.getMovieList(urlString: APIConstants.moviePosterBaseUrl + model.posterPath) { data in
            if let data = data {
                self.imgMoviePoster.image = UIImage(data: data)
            }
        }
    }
}
