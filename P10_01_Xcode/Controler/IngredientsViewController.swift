//
//  IngredientsViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 03/11/2021.
//

import UIKit
import Alamofire

class IngredientsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ingredientList = "Chicken" + " " + "salt"
        let parameters = ["app_id": ApiToken.edamamId, "app_key": ApiToken.edamamKey, "q": ingredientList]

        
        AF.request("https://api.edamam.com/api/recipes/v2",
                                 method: .get,
                                 parameters: parameters).response { reponse in
            print(reponse)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
