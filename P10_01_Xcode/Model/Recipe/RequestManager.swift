//
//  FetchData.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 24/11/2021.
//

import Foundation

protocol RequestManager {
    
    func fetchData(_ requestStatus: RequestStatus, successHandler: @escaping([Recipe]) -> Void, errorHandler: @escaping(String) -> Void)
    
    func createRecipe(_ responseArray: [RecipeDecoder.Hit]) -> [Recipe]
    
}
