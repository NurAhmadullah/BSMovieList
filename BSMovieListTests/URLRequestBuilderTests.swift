//
//  URLRequestBuilderTests.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import Foundation
import XCTest

class URLRequestBuilderTests: XCTestCase {

    func testURLRequestBuilder() {
        // Arrange
        let expectedURL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=marvel")
        
        // Act
        let request = URLRequestBuilder(baseURL: APIConstants.movieBaseUrl, httpMethod: .get)
            .addPathComponent(path: Endpoint.movieList.rawValue)
            .addQueryParameter(name: "api_key", value: APIConstants.apiKey)
            .addQueryParameter(name: "query", value: "marvel")
            .build()
        
        // Assert
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url, expectedURL)
        XCTAssertEqual(request?.httpMethod, "GET")
    }
    
    func testURLRequestBuilderWithHttpBodyAndHeaders() {
        // Arrange
        let baseURL = "https://example.com"
        let expectedURL = URL(string: "\(baseURL)/path/to/endpoint?param1=value1")!
        let requestBody = ["key": "value"]
        
        // Act
        let request = URLRequestBuilder(baseURL: baseURL, httpMethod: .post)
            .addPathComponent(path: "path")
            .addPathComponent(path: "to")
            .addPathComponent(path: "endpoint")
            .addQueryParameter(name: "param1", value: "value1")
            .setHttpBody(data: requestBody)
            .setHeader(field: "Content-Type", value: "application/json")
            .build()
        
        // Assert
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url, expectedURL)
        XCTAssertEqual(request?.httpMethod, "POST")
        XCTAssertEqual(request?.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertNotNil(request?.httpBody)
    }
}
