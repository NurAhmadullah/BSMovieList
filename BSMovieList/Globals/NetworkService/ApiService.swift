//
//  ApiService.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import Foundation

protocol ApiServiceProvider {
    func getMovieList(completion: @escaping (Movies?)->Void)
}

class ApiService: ApiServiceProvider {
    
//    static let shared = ApiService()
    var networkManager:NetworkManager!
    
    init(networkManager:NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getMovieList(completion: @escaping (Movies?)->Void){
        if let request = URLRequestBuilder(baseURL: APIConstants.movieBaseUrl, httpMethod: .get)
//            .addPathComponent(path: "search")
//            .addPathComponent(path: "movie")
            .addPathComponent(path: Endpoint.movieList.rawValue)
            .addQueryParameter(name: "api_key", value: APIConstants.apiKey)
            .addQueryParameter(name: "query", value: "marvel")
            .build(){
//            print("request url: ", request.url?.absoluteString)
            self.networkManager.performRequest(request: request, completion: completion)
        }
    }
    
    func getImage(lastPath:String,completion: @escaping (Data?)->Void){
        if let request = URLRequestBuilder(baseURL: APIConstants.moviePosterBaseUrl, httpMethod: .get)
            .addPathComponent(path: lastPath)
            .build(){
//            print("image request url: ", request.url?.absoluteString)
            self.networkManager.performDataRequest(request: request, completion: completion)
        }
    }
}
