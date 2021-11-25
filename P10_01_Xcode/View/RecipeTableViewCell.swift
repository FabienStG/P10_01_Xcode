//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 17/11/2021.
//

import UIKit
//
// MARK: - Recipe TableView Cell
//

///A specific cell used to display information from a Recipe
class RecipeTableViewCell: UITableViewCell {
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var notation: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    //
    // MARK: - Cell Life Cycle
    //
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //
    // MARK: - Internal Method
    //
    func configure(withRecipe: Recipe) {
        recipeName.text = withRecipe.name
        ingredients.text = withRecipe.ingredients
        notation.text = withRecipe.notation
        duration.text = withRecipe.duration
        recipeImage.loadFromURL(withRecipe.image)
    }
}
