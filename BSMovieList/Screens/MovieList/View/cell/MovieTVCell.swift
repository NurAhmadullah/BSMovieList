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
    var apiService:ApiService!
    var cacheManager:CacheManager!
    
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: MovieTVCellViewModel,apiService:ApiService, cacheManager:CacheManager){
        self.lblMovieTitle.text = model.title
        self.lblMovieDescription.text = model.overview
        self.imgMoviePoster.image = UIImage(named: "appLogo")
        self.apiService = apiService
        self.cacheManager = cacheManager
        if let image = self.cacheManager.getImage(forKey: model.posterPath){
            self.imgMoviePoster.image = image
        }
        DispatchQueue.global().async {
            self.apiService.getImage(lastPath: model.posterPath) { data in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imgMoviePoster.image = image
                    }
                    self.cacheManager.setImage(image, forKey: model.posterPath)
                }
            }
        }
    }
    
}
