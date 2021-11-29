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
    static var shared = RecipeDataManager()
    
    private var mode: Mode = .offline {
        didSet {
            displayableList.removeAll()
            requestRecipe = mode == .offline ? CoreDataManager.shared: NetworkManager.shared
        }
    }
    
    private var onlineRecipe: [Recipe] = []
    
    var requestRecipe: RequestRecipe
    var displayableList: [Recipe] = []
    var selectedRecipe: Recipe?

    //
    // MARK: - Initialization
    //
    init() {
        requestRecipe = CoreDataManager.shared
    }
    
    //
    // MARK: - Internal Methods
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
    
    func checkFavoriteStatus() {
        if !selectedRecipe!.isFavorite {
            selectedRecipe!.isFavorite = true
            CoreDataManager.shared.saveRecipe(selectedRecipe!)
        } else if selectedRecipe!.isFavorite {
            selectedRecipe?.isFavorite = false
            CoreDataManager.shared.deleteRecipe(name: selectedRecipe!.name)
        } else {
            return
        }
    }

    func getRecipies(_ requestStatus: RequestStatus, successHandler: @escaping() -> Void, errorHandler: @escaping(String) -> Void) {
        if requestStatus == .initial {
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
