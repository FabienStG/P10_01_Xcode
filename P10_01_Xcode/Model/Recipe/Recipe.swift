//
//  Displayable.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 15/11/2021.
//

import Foundation
//
// MARK: - Recipe
//

/// Structure use to display the Recipe of the user's screen
struct Recipe {
    //
    // MARK: - Variables And Properties
    //
    var name: String
    var image: URL
    var recipeURL: URL
    var duration: String
    var notation: String
    var ingredients: String
    var ingredientsQuantity: String
    var isFavorite: Bool
}

//
// MARK: - Mode
//
enum Mode {
    
    case online, offline
}

//
// MARK: - RequestStatus
//
enum RequestStatus {
    
    case initial, following
}
