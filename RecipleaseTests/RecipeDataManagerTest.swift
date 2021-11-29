//
//  RecipeDataManager.swift
//  RecipleaseTests
//
//  Created by Fabien Saint Germain on 28/11/2021.
//

import XCTest
@testable import Reciplease

class RecipeDataManagerTest: XCTestCase {

    func testSetModeOffline() {
        let recipeDataManager = RecipeDataManager()
            
        recipeDataManager.displayableList.append(fakeRecipe)
        XCTAssertFalse(recipeDataManager.displayableList.isEmpty)
        recipeDataManager.setMode(mode: .offline)
        XCTAssertTrue(recipeDataManager.displayableList.isEmpty)
    }
    
    func testSetModeOnline() {
        let recipeDataManager = RecipeDataManager()
            
        recipeDataManager.displayableList.append(fakeRecipe)
        XCTAssertFalse(recipeDataManager.displayableList.isEmpty)
        recipeDataManager.setMode(mode: .online)
        XCTAssertTrue(recipeDataManager.displayableList.isEmpty)
    }
    

    

}
