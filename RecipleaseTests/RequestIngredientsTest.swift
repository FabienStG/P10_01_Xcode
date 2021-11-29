//
//  RequestIngredientsTest.swift
//  RecipleaseTests
//
//  Created by Fabien Saint Germain on 29/11/2021.
//

import XCTest
@testable import Reciplease

class RequestIngredientsTest: XCTestCase {

    func testCheckIngredients() {
        
        let requestIngredients = RequestIngredients()
        
        XCTAssertFalse(requestIngredients.checkIngredient())
    }
    
    func testMakeIngredientsLists() {
        
        let requestIngredients = RequestIngredients()
        
        requestIngredients.ingredientsList.append("Egg")
        requestIngredients.ingredientsList.append("Turkey")
        
        XCTAssertTrue(requestIngredients.checkIngredient())
        
        XCTAssertEqual(requestIngredients.makeIngredientsList(), "Egg Turkey ")
    }
    
}
