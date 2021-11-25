//
//  RecipeDataManager.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 15/11/2021.
//

import Foundation
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
    
    private var mode: Mode = .offline
    
    var displayableList: [Recipe] = []
    var selectedRecipe: Recipe?
    
    //
    // MARK: - Initialization
    //
    private init() {}
    
    //
    // MARK: - Internal Methods
    func setMode(mode: Mode) {
        self.mode = mode
    }
    
    func setSelectedRecipe(_ selectedItem: Recipe) {
        selectedRecipe = selectedItem
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
        switch requestStatus {
        case .initial :
            displayableList.removeAll()
            print(displayableList)
            if mode == .online {
                NetworkManager.shared.fetchRecipe(requestStatus, successHandler: { recipies in
                    self.displayableList = recipies
                    successHandler()
                }, errorHandler: { error in
                   return errorHandler(error)
                })
            }
            if mode == .offline {
                CoreDataManager.shared.fetchRecipe(requestStatus, successHandler: { recipies in
                    self.displayableList = recipies
                    successHandler()
                }, errorHandler: { error in
                   return errorHandler(error)
                })
            }
            
        case .following :
            if mode == .online {
            NetworkManager.shared.fetchRecipe(requestStatus, successHandler: { recipies in
                self.displayableList.append(contentsOf: recipies)
                successHandler()
            }, errorHandler: { error in
              return  errorHandler(error)
            })
            }
        }
    }
}
