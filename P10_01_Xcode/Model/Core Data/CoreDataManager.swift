//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 18/11/2021.
//

import Foundation
import CoreData
//
// MARK: - Core Data Manager
//
public let coreDataStackInit = CoreDataStack()

/// A specific class for managing the Core Data "SavedRecipe" entity
/// Save a recipe, delete it, create SavedRecipe from Recipe and vice versa
class CoreDataManager {
    //
    // MARK: - Constant
    //
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    //
    // MARK: - Properties And Variables
    //
    static var shared = CoreDataManager(managedObjectContext: coreDataStackInit.mainContext, coreDataStack: coreDataStackInit)
    
    //
    // MARK: - Initialization
    //
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    //
    // MARK: - Internal Methods
    //
    func deleteRecipe(name: String){
        let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "name LIKE %@", name)
        guard let results = try? managedObjectContext.fetch(request) else {
            return
        }
        results.forEach { recipe in
            managedObjectContext.delete(recipe)
        }
        coreDataStack.saveContext(managedObjectContext)
    }

    func saveRecipe(_ recipeToSave: Recipe) {
        let recipe = SavedRecipe(context: managedObjectContext)
        recipe.name = recipeToSave.name
        recipe.notation = recipeToSave.notation
        recipe.isFavorite = true
        recipe.duration = recipeToSave.duration
        recipe.image = recipeToSave.image
        recipe.recipeURL = recipeToSave.recipeURL
        recipe.ingredients = recipeToSave.ingredients
        recipe.ingredientsQuantity = recipeToSave.ingredientsQuantity
        
        coreDataStack.saveContext(managedObjectContext)
    }
}

//
// MARK: - Request Recipe Protocol
//
extension CoreDataManager: RequestRecipe {

    func fetchRecipe(_ requestStatus: RequestStatus, successHandler: @escaping([Recipe]) -> Void, errorHandler: @escaping(String) -> Void) {
        let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        guard let recipies = try? managedObjectContext.fetch(request) else {
          return errorHandler("Error in Core Data")
        }
        let result = self.createRecipe(recipies)
        successHandler(result)
    }
    
    func createRecipe(_ responseArray: [SavedRecipe]) -> [Recipe] {
        var recipies: [Recipe] = []
        responseArray.forEach { response in
            let recipe = Recipe(name: response.name!, image: response.image!, recipeURL: response.recipeURL!, duration: response.duration!,
                                notation: response.notation!, ingredients: response.ingredients!,
                                ingredientsQuantity: response.ingredientsQuantity!, isFavorite: true)
            recipies.append(recipe)
        }
        return recipies
    }
}
