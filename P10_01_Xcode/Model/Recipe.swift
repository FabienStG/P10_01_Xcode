//
//  Recipe.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 02/11/2021.
//

import Foundation
import Alamofire

struct Recipe {
    
    static let parameters = ["app_id": ApiToken.edamamId, "app_key": ApiToken.edamamKey, "q": ingredientList, "type": "public"]
    static let ingredientList = "Chicken" + " " + "salt"
    
    func makeRequest() throws {
    AF.request("https://api.edamam.com/api/recipes/v2",
                             method: .get,
                             parameters: Recipe.parameters).validate().responseJSON { response in
        switch response.result {
        case .success( _):
            do {
                let recipiesList = try JSONDecoder().decode(RecipeDecoder, from: response)
            }
        }
    }
    
}
