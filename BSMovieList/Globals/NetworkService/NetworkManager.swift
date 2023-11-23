//
//  ApiService.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import Foundation

class NetworkManager {
    
//    static let shared = NetworkManager()
    
    init() {}
    
    func performRequest<T:Codable>(request:URLRequest, completion: @escaping (T?)->Void){
        self.performDataRequest(request: request) { data in
            if let data = data {
                self.parseData(data: data, completion: completion)
            }
        }
    }
    
    func performDataRequest(request:URLRequest, completion: @escaping (Data?)->Void){
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data)
        }
        dataTask.resume()
    }
    
    private func parseData<T:Codable>(data:Data,completion: @escaping (T?)->Void){
        do{
            let resp = try JSONDecoder().decode(T.self, from: data)
            completion(resp)
        }
        catch let error {
            print("decode error: ",error.localizedDescription)
        }
    }
}
