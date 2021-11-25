//
//  Displayable.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 15/11/2021.
//

import Foundation

struct Recipe {
    
    var name: String
    var image: URL
    var recipeURL: URL
    var duration: String
    var notation: String
    var ingredients: String
    var ingredientsQuantity: String
    var isFavorite: Bool

}

enum Mode {
    
    case online, offline
}

enum RequestStatus {
    
    case initial, following
}
