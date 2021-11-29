//
//  MockedData.swift
//  RecipleaseTests
//
//  Created by Fabien Saint Germain on 29/11/2021.
//

import Foundation

class MockedData {
    
    static var correctRecipeData: URL {
        let bundle = Bundle(for: MockedData.self)
        let url = bundle.url(forResource: "FakeRecipiesData", withExtension: "json")!
        return url
    }
    
    static var incorectRecipeData = "error".data(using: .utf8)!
}
