//
//  IngredientsData.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 29/11/2021.
//

import Foundation

class RequestIngredients {
//
// MARK: - Private Methods
//
    static var shared = RequestIngredients()
    //
    // MARK: - Private Methods
    //
    var ingredientsList: [String] = []
    //
    // MARK: - Internal Methods
    //
    func clearIngredientsList() {
        ingredientsList = []
    }
    
    func deleteIngredient(at index: Int){
        ingredientsList.remove(at: index)
    }
    
    func checkIngredient() -> Bool {
        if ingredientsList.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func makeIngredientsList() -> String {
        print("Requête - Création des ingrédients suite - 5")
       var ingredientListRequest = ""
        ingredientsList.forEach { ingredient in
            ingredientListRequest += ingredient + " "
        }
        return ingredientListRequest
    }
}

