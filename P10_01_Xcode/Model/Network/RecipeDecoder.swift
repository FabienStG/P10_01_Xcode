//
//  Recipe.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 05/11/2021.
//

import Foundation

struct RecipeDecoder: Decodable {
    let _links: Link
    let hits: [Hit]
    
    struct Link: Decodable {
        let next: Next
        
        struct Next: Decodable {
            let href: String
        }
    }
    
    struct Hit: Decodable {
        let recipe: Recipe
    }

    struct Recipe: Decodable {
        let label: String
        let image: URL
        let url: URL
        let ingredients: [Ingredient]
        let totalTime: Double
        let yield: Int
    }
}

struct Ingredient: Codable {
    let text: String
    let food: String
}
