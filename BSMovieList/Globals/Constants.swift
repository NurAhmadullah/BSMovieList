//
//  Constants.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import Foundation

class APIConstants {
    static let moviePosterBaseUrl = "https://image.tmdb.org/t/p/w500"
    static let movieBaseUrl = "https://api.themoviedb.org/3"
    static let apiKey = "38e61227f85671163c275f9bd95a8803"
}

enum Endpoint:String {
    case movieList = "/search/movie"
}


enum ContentType : String {
    case applicatioinJson = "application/json"
    case textHtml = "text/html"
    case applicationUrlencoded = "application/x-www-form-urlencoded"
}

enum APIError : Error {
    case internalError
    case serverError
    case parsingError
}



