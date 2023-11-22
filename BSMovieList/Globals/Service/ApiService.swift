//
//  ApiService.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import Foundation

class ApiService {
    
    static let shared = ApiService()
    
    init() {}
    
    func getMovieList(urlString:String, completion: @escaping (Data?)->Void){
        if let url = URL(string: urlString){
            let request = URLRequest(url: url)
//            request.httpMethod = "GET"
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    completion(data)
                }
                else{
                    completion(nil)
                }
            }
        }
    }
}
