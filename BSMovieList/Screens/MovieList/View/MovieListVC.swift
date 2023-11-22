//
//  ViewController.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import UIKit

/*
 --- implementation
    . api using builder
    . image and data caching, also implement url-caching with correct cache policy
        --- also implement lazy loading
        --- maybe SDWebImage will be better
    . implement prefetch on TV
    . perform Unit-Testing
 */


class MovieListVC: UIViewController {
    
    var movies:[Movie] = []
    
    
    @IBOutlet weak var movieListTV: UITableView!{
        didSet{
            self.movieListTV.delegate = self
            self.movieListTV.dataSource = self
//            self.movieListTV.backgroundColor = .clear
            self.movieListTV.backgroundColor = .green
            self.movieListTV.register(MovieTVCell.nib, forCellReuseIdentifier: MovieTVCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            ApiService.shared.getMovieList(urlString: "https://api.tmdb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=marvel") { data in
                if let data = data {
                    do{
                        let resp = try JSONDecoder().decode(Movies.self, from: data)
                        self.movies = resp.results
                        self.movieListTV.reloadData()
                        print("movie count: ", self.movies.count)
                    }
                    catch let error {
                        print("error : \(error.localizedDescription)")
                    }
                }
            }
        }
    }


}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieListTV.dequeueReusableCell(withIdentifier: MovieTVCell.identifier, for: indexPath) as! MovieTVCell
        cell.configure(model: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
