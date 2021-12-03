//
//  MockedData.swift
//  RecipleaseTests
//
//  Created by Fabien Saint Germain on 29/11/2021.
//

import Foundation
@testable import Reciplease
//
// MARK: - MockedData
//

/// Return the FakeRecipeData JSON during the tests to avoid the real server call
class MockedData {
    
    static let fakeRecipe = Recipe(
        name: "Name", image: fakeURL, recipeURL: fakeURL, duration: "Duration",
        notation: "Notation", ingredients: "Ingredients", ingredientsQuantity: "Quantity", isFavorite: false)
    
    static let fakeURL: URL = URL(string: "test")!
    
    static var correctRecipeData: URL {
        let bundle = Bundle(for: MockedData.self)
        let url = bundle.url(forResource: "FakeRecipiesData", withExtension: "json")!
        return url
    }
    
    static var incorectRecipeData = "error".data(using: .utf8)!
}
