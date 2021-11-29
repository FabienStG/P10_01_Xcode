//
//  FakeRecipe.swift
//  RecipleaseTests
//
//  Created by Fabien Saint Germain on 29/11/2021.
//

import Foundation
@testable import Reciplease

let fakeURL: URL = URL(string: "test")!

let fakeRecipe = Recipe(name: "Name", image: fakeURL, recipeURL: fakeURL, duration: "Duration", notation: "Notation", ingredients: "Ingredients", ingredientsQuantity: "Quantity", isFavorite: true)
