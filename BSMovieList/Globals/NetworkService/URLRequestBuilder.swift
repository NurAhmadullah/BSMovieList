//
//  URLRequestBuilder.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 23/11/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

class URLRequestBuilder {
    
    private var urlComponents: URLComponents!
    private var httpMethod: HTTPMethod
    private var httpBody: Data?
    private var headers: [String: String] = [:]
    
    init(baseURL: String, httpMethod: HTTPMethod) {
        
        urlComponents = URLComponents(string: baseURL)
        self.httpMethod = httpMethod
        
    }
    
    func addPathComponent( path: String) -> Self {
        
        let currentPath = urlComponents.path
        if(path.hasPrefix("/"))
        {
            urlComponents.path = "\(currentPath)\(path)"
        }
        else{
            urlComponents.path = "\(currentPath)/\(path)"
        }
        
        return self
        
    }
    
    func addQueryParameter(name: String, value: String) -> Self {
        
        let queryItem = URLQueryItem(name: name, value: value)
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + [queryItem]
        return self
        
    }
    
    
    func setHttpBody<T: Encodable>(data: T) -> Self {
        
        self.httpBody = try? JSONEncoder().encode(data)
        return self
        
    }
    
    func setHeader(field: String, value: String) -> Self {
        
        headers[field] = value
        return self
        
    }
    
    func build() -> URLRequest? {
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody
        
        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}

