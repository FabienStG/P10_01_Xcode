//
//  Recipe.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 02/11/2021.
//

import Foundation
import Alamofire
//
// MARK: - Network Manager
//

///Class Network Manager
///Make the API calls, generate the ingredients list for the request, manage the Ingredients used for the TableView
///Parse the JSON response into a Decoder and create the Recipe array
class NetworkManager {
    //
    // MARK: - Variables And Properties
    //
    static var shared = NetworkManager()

    var nextPage = ""
    var paginationFinished = true
    
    private var recipeSession = Session.default
       
    //
    // MARK: - Initialization
    //
    init(recipeSession: Session) {
        self.recipeSession = recipeSession
    }
    
    private init() {}

    //
    // MARK: - Private Methods
    //
    private func makeParameters() -> [String : String] {
         let ingredientsRequest = RequestIngredients.shared.makeIngredientsList()
         let parameters = [
             "app_id": ApiToken.edamamId, "app_key": ApiToken.edamamKey,
             "q": ingredientsRequest, "type": "public"]
         return parameters
     }
    
    private func switchRequest(_ requestStatus: RequestStatus) -> DataRequest {
        switch requestStatus {
        case .initial:
            return recipeSession.request("https://api.edamam.com/api/recipes/v2", parameters: makeParameters())
        case .following:
            return recipeSession.request(nextPage)
        }
    }
    
    private func displayIngredientName(_ ingredientsList: [Ingredient]) -> String {
        var returningString = ""
        ingredientsList.forEach { ingredient in
            returningString += ingredient.food + ", "
        }
        returningString.removeLast(2)
        return returningString
    }
    
    private func displayIngredientQuantity(_ ingredientsList: [Ingredient]) -> String {
        var returningString = ""
        ingredientsList.forEach { ingredient in
            returningString += "-" + ingredient.text + "\n"
        }
        returningString.removeLast(1)
        return returningString
    }
}

//
// MARK: - RequestRecipe Protocol
//
extension NetworkManager: RequestRecipe {
    
    func createRecipe(_ responseArray: [RecipeDecoder.Hit]) -> [Recipe] {
        var onlineRecipies: [Recipe] = []
         responseArray.forEach { response in
             let ingredients = response.recipe.ingredients
             let recipe = Recipe(
                 name: response.recipe.label, image: response.recipe.image, recipeURL: response.recipe.url,
                 duration: String(response.recipe.totalTime), notation: String(response.recipe.yield), ingredients: displayIngredientName(ingredients),
                 ingredientsQuantity: displayIngredientQuantity(ingredients), isFavorite: false)
             onlineRecipies.append(recipe)
         }
         return onlineRecipies
    }

    func fetchRecipe(_ requestStatus: RequestStatus, successHandler: @escaping ([Recipe]) -> Void, errorHandler: @escaping (String) -> Void) {
        paginationFinished = false
        let request = switchRequest(requestStatus)
        request.validate().responseDecodable(of: RecipeDecoder.self) { responseJSON in
            switch responseJSON.result {
            case .success :
                guard let JSON = responseJSON.value?.hits,
                      let nextPageURL = responseJSON.value?._links.next.href else {
                   return errorHandler("No data")
                }
                let result = self.createRecipe(JSON)
                self.nextPage = nextPageURL.description
                successHandler(result)
            case .failure :
                return errorHandler("Ingredients not recognized")
            }
            self.paginationFinished = true
        }
    }
}

