//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 03/11/2021.
//

import UIKit
//
// MARK: - Recipe View Controller
//
class RecipeViewController: UIViewController {
    //
    // MARK: - IBOutlets
    //
    @IBOutlet var recipeView: RecipeView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    //
    let dataManager = RecipeDataManager.shared()
    
    //
    // MARK: - View Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeView.setRecipeView(withRecipe: dataManager.selectedRecipe!)
        changeFavoriteButton()
        getDirectionsButton.layer.cornerRadius = 5.0
    }

    //
    // MARK: - Internal Methods
    @IBAction func openLink(_ sender: Any) {
        didTapOpenLink()
    }
    
    @IBAction func toggleFavorite(_ sender: Any) {
        dataManager.checkFavoriteStatus()
        changeFavoriteButton()
    }
    
    //
    // MARK: - Private Methods
    //
    private func didTapOpenLink() {
        if let url = URL(string: "\(dataManager.selectedRecipe!.recipeURL)") {
        UIApplication.shared.open(url)
        }
    }
    
    private func changeFavoriteButton() {
        if dataManager.selectedRecipe!.isFavorite {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}


