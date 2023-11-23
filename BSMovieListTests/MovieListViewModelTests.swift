//
//  MovieListViewModelTests.swift
//  BSMovieList
//
//  Created by Sohag Macbook Pro on 22/11/23.
//

import Foundation
import XCTest

class MovieListViewModelTests: XCTestCase {

    // Mock ApiService for testing
    class MockApiService: ApiServiceProvider {
        let networkManager = NetworkManager()
        func getMovieList(completion: @escaping (Movies?)->Void){
            if let request = URLRequestBuilder(baseURL: APIConstants.movieBaseUrl, httpMethod: .get)
    //            .addPathComponent(path: "search")
    //            .addPathComponent(path: "movie")
                .addPathComponent(path: Endpoint.movieList.rawValue)
                .addQueryParameter(name: "api_key", value: APIConstants.apiKey)
                .addQueryParameter(name: "query", value: "marvel")
                .build(){
                self.networkManager.performRequest(request: request, completion: completion)
            }
        }
    }

    func testFetchData() {
        // Arrange
        let mockApiService = MockApiService()
        let viewModel = MovieListViewModel(apiService: mockApiService)
        let expectation = XCTestExpectation(description: "Movies are fetched")
        
        // Act
        viewModel.fetchData()
        
        // Assert
        viewModel.movies.bind { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                XCTAssertEqual(viewModel.movies.value!.count, 20)
                XCTAssertEqual(viewModel.movies.value![0].title, "Marvel")
                XCTAssertEqual(viewModel.movies.value![0].posterPath, "/p6XFjLX7XDnAMCczOBCevVaZpFv.jpg")
                XCTAssertEqual(viewModel.movies.value![0].overview, "The quintessential student film of 1969.")
                
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
