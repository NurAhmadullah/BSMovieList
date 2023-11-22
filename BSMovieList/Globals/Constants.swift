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


enum RetryParamValue : Int {
    case minimumRetryCount = 3
    case noRetry = 0
}

enum Method : String {
    case GET
    case POST
}
