//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 03/11/2021.
//

import UIKit

class RecipeViewController: UIViewController {
    
    @IBOutlet var recipeView: RecipeView!
    @IBOutlet weak var favoriteButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeView.setRecipeView(withRecipe: RecipeDataManager.shared.selectedRecipe!)
        changeFavoriteButton()
    }

    @IBAction func openLink(_ sender: Any) {
        didTapOpenLink()
    }
    
    private func didTapOpenLink() {
        if let url = URL(string: "\(RecipeDataManager.shared.selectedRecipe!.recipeURL)") {
        UIApplication.shared.open(url)
        }
    }
    
    @IBAction func toggleFavorite(_ sender: Any) {
        RecipeDataManager.shared.checkFavoriteStatus()
        changeFavoriteButton()
    }
    
    func changeFavoriteButton() {
        if RecipeDataManager.shared.selectedRecipe!.isFavorite {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}


