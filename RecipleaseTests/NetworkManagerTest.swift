//
//  NetworkManagerTest.swift
//  RecipleaseTests
//
//  Created by Fabien Saint Germain on 28/11/2021.
//

import XCTest
@testable import Reciplease
import Alamofire
import Mocker

class NetworkManagerTest: XCTestCase {

    func testFetchRecipeWithCorrectData() {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        
        let fakeSession = Session(configuration: configuration)
        let networkManager = NetworkManager(recipeSession: fakeSession)
    
        let url = URL(string: ApiToken.mockingURL)!
        let mock = Mock(url: url, dataType: .json, statusCode: 200, data: [.get : try! Data(contentsOf: MockedData.correctRecipeData)])
        mock.register()
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        networkManager.fetchRecipe(.initial) { recipe in
            XCTAssertNotNil(recipe)
            expectation.fulfill()
        } errorHandler: { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchRecipeWithIncorrectData() {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        
        let fakeSession = Session(configuration: configuration)
        let networkManager = NetworkManager(recipeSession: fakeSession)
    
        let url = URL(string: ApiToken.mockingURL)!
        let mock = Mock(url: url, dataType: .json, statusCode: 500, data: [.get: try! Data(contentsOf: MockedData.correctRecipeData)])
        mock.register()
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        networkManager.fetchRecipe(.initial) { recipe in
            XCTAssertNil(recipe)
            expectation.fulfill()
        } errorHandler: { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFollowingFetchingData() {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        
        let fakeSession = Session(configuration: configuration)
        let networkManager = NetworkManager(recipeSession: fakeSession)
        networkManager.nextPage = "http://test.exemple.com"
    
        let url = URL(string: "http://test.exemple.com")!
        let mock = Mock(url: url, dataType: .json, statusCode: 200, data: [.get: try! Data(contentsOf: MockedData.correctRecipeData)])
        mock.register()
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        networkManager.fetchRecipe(.following) { recipe in
            XCTAssertNotNil(recipe)
            expectation.fulfill()
        } errorHandler: { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }

}

