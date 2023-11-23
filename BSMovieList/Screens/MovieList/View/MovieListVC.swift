//
//  ViewController.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import UIKit

class MovieListVC: UIViewController, CoordinatorStoryboard, UITableViewDataSourcePrefetching {
    
    let apiService = ApiService(networkManager: NetworkManager())
    var viewModel: MovieListViewModel!
    let cacheManager = CacheManager()
    
    
    @IBOutlet weak var movieListTV: UITableView!{
        didSet{
            self.movieListTV.delegate = self
            self.movieListTV.dataSource = self
            self.movieListTV.prefetchDataSource = self
            self.movieListTV.backgroundColor = .clear
            self.movieListTV.estimatedRowHeight = UITableView.automaticDimension
            self.movieListTV.register(MovieTVCell.nib, forCellReuseIdentifier: MovieTVCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movie List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.viewModel = MovieListViewModel(apiService: self.apiService)
        
        self.viewModel.movies.bind { _ in
            DispatchQueue.main.async {
                self.movieListTV.reloadData()
            }
        }
        
        self.viewModel.fetchData()
    }
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movies.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieListTV.dequeueReusableCell(withIdentifier: MovieTVCell.identifier, for: indexPath) as! MovieTVCell
        if let model = self.viewModel.movies.value?[indexPath.row] {
            cell.configure(model: model,apiService: self.apiService,cacheManager: self.cacheManager)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let model = self.viewModel.movies.value?[indexPath.row] {
                // here checking image exist in cache or not
                if let _ = self.cacheManager.getImage(forKey: model.posterPath){
                }
                else {
                    // if image not in cache, then prefetch image in background thread
                    DispatchQueue.global().async {
                        self.apiService.getImage(lastPath: model.posterPath) { _ in
                        }
                    }
                }
            }
        }
    }
}
