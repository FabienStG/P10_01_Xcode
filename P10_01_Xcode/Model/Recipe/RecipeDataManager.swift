//
//  RecipeDataManager.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 15/11/2021.
//

import Foundation

class RecipeDataManager {
    

    private var mode: Mode = .offline
    
    static var shared = RecipeDataManager()
    
    private init() {}
    
    var displayableList: [Recipe] = []
    
    var selectedRecipe: Recipe?
    
    func setMode(mode: Mode) {
        self.mode = mode
    }
    
    func setSelectedRecipe(_ selectedItem: Recipe) {
        selectedRecipe = selectedItem
    }
    
    func getRecipies(_ requestStatus: RequestStatus, successHandler: @escaping() -> Void, errorHandler: @escaping(String) -> Void) {
        switch requestStatus {
        case .initial :
            displayableList.removeAll()
            print(displayableList)
            if mode == .online {
                NetworkingClient.shared.fetchData(requestStatus, successHandler: { recipies in
                    self.displayableList = recipies
                    successHandler()
                }, errorHandler: { error in
                   return errorHandler(error)
                })
            }
            if mode == .offline {
                CoreDataManager.shared.fetchData(requestStatus, successHandler: { recipies in
                    self.displayableList = recipies
                    successHandler()
                }, errorHandler: { error in
                   return errorHandler(error)
                })
            }
            
        case .following :
            if mode == .online {
            NetworkingClient.shared.fetchData(requestStatus, successHandler: { recipies in
                self.displayableList.append(contentsOf: recipies)
                successHandler()
            }, errorHandler: { error in
              return  errorHandler(error)
            })
            }
        }
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
}
