//
//  ApiService.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import Foundation

//let parameter_separator = "&"
let increment_retry_call : Int = 1


class NetworkManager {
    
    static let shared = NetworkManager()
    
//    let retryCounter = 3
    var counter = 0
    
    init() {
        
    }
    
    
    func request(baseUrl : String,endPoint : Endpoint, params :[String: String]?,body : Data?, method: Method, contentType : ContentType, retryCounter : RetryParamValue, completion: @escaping((Result<Data, APIError>) -> Void)) {
        var stringParam = ""
        var path = ""
        if params != nil {
            if let param = params {
                if param.count > 0 {
//                    stringParam = NSArray(array:param).componentsJoined(by: parameter_separator)
                    for (idx,prm) in param.enumerated() {
                        stringParam += (idx == 0 ? "?":"&") + prm.key + "=" + prm.value
                    }
                } else {
//                    stringParam = NSArray(array:param).componentsJoined(by: "")
                    stringParam = ""
                }
            }
            path = "\(baseUrl)\(endPoint.rawValue)\(stringParam)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        } else {
            path = "\(baseUrl)\(endPoint.rawValue)"
        }

        guard let url = URL(string: path)
        else {completion(.failure(.internalError)); return}

        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": contentType.rawValue]

        if method == .POST {
            if let requestBody = body {
                request.httpBody = requestBody
            }
        }
        call(with: request, retryCounter : retryCounter, completion: completion)
    }
    
    private func call(with request: URLRequest, retryCounter : RetryParamValue, completion: @escaping((Result<Data, APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                print("response: \(response.statusCode)")
            }
            
            guard error == nil
            else {
                if(self.counter < retryCounter.rawValue){
                    self.call(with: request, retryCounter : retryCounter, completion: completion)
                    self.counter = self.counter + increment_retry_call
                }
                completion(.failure(.serverError)); return}
            do {
                guard let data = data
                else {completion(.failure(.serverError)); return}
                completion(Result.success(data))
            }
        }
        dataTask.resume()
    }
}
