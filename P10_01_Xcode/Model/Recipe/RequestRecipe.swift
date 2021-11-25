//
//  FetchData.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 24/11/2021.
//

import Foundation
//
// MARK: - Request Recipe
//

/// Protocol used to fetch online and offline recipe and return Recipe array
/// Turn the response into the displayable object Recipe
protocol RequestRecipe {
    
    func fetchRecipe(_ requestStatus: RequestStatus, successHandler: @escaping([Recipe]) -> Void, errorHandler: @escaping(String) -> Void)
    
    func createRecipe(_ responseArray: [RecipeDecoder.Hit]) -> [Recipe]
    
}
