//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 17/11/2021.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var notation: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(withRecipe: Recipe) {
        recipeName.text = withRecipe.name
        ingredients.text = withRecipe.ingredients
        notation.text = withRecipe.notation
        duration.text = withRecipe.duration
        recipeImage.loadFromURL(withRecipe.image)
    }
}
