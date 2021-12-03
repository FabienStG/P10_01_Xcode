//
//  Recipe.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 05/11/2021.
//

import Foundation
//
// MARK: - RecipeDecoder
//

///Structure used to decode the JSON response from the Edamam API
struct RecipeDecoder: Decodable {
    //
    // MARK: - Link
    //
    struct Link: Decodable {
        let next: Next
        
        //
        // MARK: - Next
        //
        struct Next: Decodable {
            let href: String
        }
    }
    
    //
    // MARK: - Hit
    //
    struct Hit: Decodable {
        let recipe: Recipe
    }

    //
    // MARK: - Recipe
    //
    struct Recipe: Decodable {
        let label: String
        let image: URL
        let url: URL
        let ingredients: [Ingredient]
        let totalTime: Double
        let yield: Double
    }
    
    //
    // MARK: - Constants
    //
    let _links: Link
    let hits: [Hit]
}

//
// MARK: - Ingredient
//
struct Ingredient: Codable {
    let text: String
    let food: String
}
