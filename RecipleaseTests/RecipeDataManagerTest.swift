//
//  RecipeDataManager.swift
//  RecipleaseTests
//
//  Created by Fabien Saint Germain on 28/11/2021.
//

import XCTest
import Alamofire
import CoreData
import Mocker
@testable import Reciplease

class RecipeDataManagerTest: XCTestCase {
    
    var recipeDataManager: RecipeDataManager!
    var coreDataStack: CoreDataStack!
    var session: Session!
   
    override func setUp() {
        super.setUp()
        coreDataStack = FakeCoreDataStack()

        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        session = Session(configuration: configuration)
        
        recipeDataManager = RecipeDataManager(networkManager: NetworkManager(recipeSession: session), coreDataManager: CoreDataManager(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack))
    }
    
    override func tearDown() {
        super.tearDown()
        recipeDataManager = nil
        coreDataStack = nil
        session = nil
    }

    func testSetMode() {
    
        recipeDataManager.displayableList.append(MockedData.fakeRecipe)
        XCTAssertFalse(recipeDataManager.displayableList.isEmpty)
        recipeDataManager.setMode(mode: .online)
        XCTAssertTrue(recipeDataManager.displayableList.isEmpty)
    }
    
    func testGiveUnfavoriteRecipeWhenToogleFavoriteThenRecipeSaveInCoreData() {
        
        recipeDataManager.setSelectedRecipe(MockedData.fakeRecipe)
        
        recipeDataManager.checkFavoriteStatus()
        XCTAssertTrue(recipeDataManager.selectedRecipe!.isFavorite)
        
        recipeDataManager.setMode(mode: .offline)
        recipeDataManager.getRecipies(.initial) {
            XCTAssertNotNil(self.recipeDataManager.displayableList)
            XCTAssertTrue(self.recipeDataManager.displayableList.count == 1)
            XCTAssertTrue(self.recipeDataManager.displayableList[0].name == "Name")
        } errorHandler: { error in
            XCTAssertNil(error)
        }

    }
    
    func testGivenFavoriteRecipeWhenToggleFavoriteThenRecipeDeleteFromCoreData() {
        
        recipeDataManager.setSelectedRecipe(MockedData.fakeRecipe)
        
        recipeDataManager.checkFavoriteStatus()
        XCTAssertTrue(recipeDataManager.selectedRecipe!.isFavorite)
        
        recipeDataManager.setMode(mode: .offline)
        recipeDataManager.getRecipies(.initial) {
            XCTAssertNotNil(self.recipeDataManager.displayableList)
            XCTAssertTrue(self.recipeDataManager.displayableList.count == 1)
            XCTAssertTrue(self.recipeDataManager.displayableList[0].name == "Name")
        } errorHandler: { error in
            XCTAssertNil(error)
        }
        
        recipeDataManager.checkFavoriteStatus()
        XCTAssertFalse(recipeDataManager.selectedRecipe!.isFavorite)
        
        recipeDataManager.getRecipies(.initial) {
            XCTAssertTrue(self.recipeDataManager.displayableList.isEmpty)
        } errorHandler: { error in
            XCTAssertNil(error)
        }
    }
    
    func testInitialFetchOnlineRecipies() {
        
        recipeDataManager.setMode(mode: .online)
        let url = URL(string: ApiToken.mockingURL)!
        let mock = Mock(url: url, dataType: .json, statusCode: 200, data: [.get: try! Data(contentsOf: MockedData.correctRecipeData)])
        mock.register()
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        recipeDataManager.getRecipies(.initial) {
            XCTAssertFalse(self.recipeDataManager.paginationFinished())
            XCTAssertNotNil(self.recipeDataManager.displayableList)
            XCTAssertTrue(self.recipeDataManager.displayableList[0].name == "Salt-Roasted Chicken")
            expectation.fulfill()
        } errorHandler: { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
        XCTAssertTrue(recipeDataManager.paginationFinished())
    }
}
