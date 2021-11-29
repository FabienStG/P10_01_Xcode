//
//  CoreDataManagerTest.swift
//  RecipleaseTests
//
//  Created by Fabien Saint Germain on 28/11/2021.
//

import XCTest
@testable import Reciplease
import CoreData

class CoreDataManagerTest: XCTestCase {

    var coreDataManager: CoreDataManager!
    var coreDataStack: CoreDataStack!
    let fakeURL: URL = URL(string: "test")!
    

    override func setUp() {
        super.setUp()
        coreDataStack = FakeCoreDataStack()
        coreDataManager = CoreDataManager(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    func testAddRecipeAndSavedAfterAdding() {
        let derivedContext = coreDataStack.newDerivedContext()
        coreDataManager = CoreDataManager(managedObjectContext: derivedContext, coreDataStack: coreDataStack)
        
        let recipe = Recipe(name: "Name", image: fakeURL, recipeURL: fakeURL, duration: "Duration", notation: "Notation", ingredients: "Ingredients", ingredientsQuantity: "Quantity", isFavorite: true)
        
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.mainContext) { _ in
            return true
        }
        
        derivedContext.perform {
            self.coreDataManager.saveRecipe(recipe)
        }
        
        waitForExpectations(timeout: 0.5) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    
    func testGetRecipeByFetchRequest() {
        let recipe = Recipe(name: "Name", image: fakeURL, recipeURL: fakeURL, duration: "Duration", notation: "Notation", ingredients: "Ingredients", ingredientsQuantity: "Quantity", isFavorite: true)
        
        coreDataManager.saveRecipe(recipe)
        
        coreDataManager.fetchRecipe(.initial) { recipe in
            XCTAssertNotNil(recipe)
            XCTAssertTrue(recipe.count == 1)
            XCTAssertEqual(recipe[0].name, "Name")
        } errorHandler: { error in
            XCTAssertNil(error)
        }
    }
    
    func testDeleteRecipeByNameGiven() {
        let recipe = Recipe(name: "Name", image: fakeURL, recipeURL: fakeURL, duration: "Duration", notation: "Notation", ingredients: "Ingredients", ingredientsQuantity: "Quantity", isFavorite: true)
        
        coreDataManager.saveRecipe(recipe)
        
        coreDataManager.fetchRecipe(.initial) { recipe in
            XCTAssertNotNil(recipe)
            XCTAssertTrue(recipe.count == 1)
            XCTAssertEqual(recipe[0].name, "Name")
        } errorHandler: { error in
            XCTAssertNil(error)
        }
        
        coreDataManager.deleteRecipe(name: recipe.name)
        
        coreDataManager.fetchRecipe(.initial) { recipe in
            XCTAssertTrue(recipe.isEmpty)
        } errorHandler: { error in
            XCTAssertNil(error)
        }
    }
    
}
