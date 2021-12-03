//
//  RecipeDataManager.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 15/11/2021.
//

import Foundation
import Alamofire
import CoreData
//
// MARK: - Recipe Data Manager
//

/// Clas Recipe Data Manager
/// The only class called by the view. Manage all the Recipe, offline and online.
class RecipeDataManager {
    //
    // MARK: - Variables And Properties
    //
    private static var _shared: RecipeDataManager?
    
    private var mode: Mode = .offline {
        didSet {
            requestRecipe = mode == .offline ? coreDataManager: networkManager
            if oldValue != mode {
            displayableList.removeAll()
            }
        }
    }
    
    private var onlineRecipe: [Recipe] = []
    
    var requestRecipe: RequestRecipe
    var displayableList: [Recipe] = []
    var selectedRecipe: Recipe?
    
    //
    // MARK: - Constants
    //
    private let networkManager: NetworkManager
    private let coreDataManager: CoreDataManager

    //
    // MARK: - Initialization
    //
    init(networkManager: NetworkManager, coreDataManager: CoreDataManager) {
        self.networkManager = networkManager
        self.coreDataManager = coreDataManager
        self.requestRecipe = coreDataManager
    }
    
    //
    // MARK: - Internal Methods
    //
    static func initialiazed(networkManager: NetworkManager, coreDataManager: CoreDataManager) {
        _shared = RecipeDataManager(networkManager: networkManager, coreDataManager: coreDataManager)
    }
    
    static func shared() -> RecipeDataManager {
        return _shared!
    }
    
    func setMode(mode: Mode) {
        self.mode = mode
    }

    func setSelectedRecipe(_ selectedItem: Recipe) {
        selectedRecipe = selectedItem
    }
    
    func removeOnlineList() {
        onlineRecipe.removeAll()
    }
    
    func showPreviousOnlineRequest() {
        displayableList = onlineRecipe
    }
    
    func paginationFinished() ->Bool {
        return networkManager.paginationFinished
    }
    
    func checkFavoriteStatus() {
        if !selectedRecipe!.isFavorite {
            selectedRecipe!.isFavorite = true
            coreDataManager.saveRecipe(selectedRecipe!)
        } else if selectedRecipe!.isFavorite {
            selectedRecipe?.isFavorite = false
            coreDataManager.deleteRecipe(name: selectedRecipe!.name)
        } else {
            return
        }
    }

    func getRecipies(_ requestStatus: RequestStatus, successHandler: @escaping() -> Void, errorHandler: @escaping(String) -> Void) {
        if requestStatus == .initial {
            print("Send Request, removeAll")
            displayableList.removeAll()
        }
        requestRecipe.fetchRecipe(requestStatus, successHandler: { recipies in
            if self.mode == .online {
                self.onlineRecipe = self.onlineRecipe + recipies
            }
            self.displayableList = self.displayableList + recipies
            successHandler()
        }, errorHandler: { error in
           return errorHandler(error)
        })
    }
}
