//
//  MovieListViewModel.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import Foundation

class MovieTVCellViewModel {
    let title:String
    let posterPath:String
    let overview:String
    init(title: String, posterPath: String, overview: String) {
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
    }
}

class MovieListViewModel{
    private var apiService: ApiServiceProvider
    var movies:Observable<[MovieTVCellViewModel]> = Observable([])
    
    init(apiService: ApiServiceProvider) {
        self.apiService = apiService
    }
    
    func fetchData(){
        self.apiService.getMovieList { movies in
            if let movies = movies {
                self.movies.value = movies.results.compactMap{MovieTVCellViewModel(title: $0.title, posterPath: $0.posterPath,overview: $0.overview)}
            }
        }
    }
}
