//
//  IngredientsViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 03/11/2021.
//

import UIKit
//
// MARK: - Ingredients View Controller
//
class IngredientsViewController: UIViewController {
   //
// MARK: - IBOutlets
    //
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    //
    // MARK: - View Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !RequestIngredients.shared.checkIngredient() {
            presentAlert(title: "Error", message: "Write ingredient first")
            return false
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let successVS = segue.destination as? OnlineTableViewController {
            successVS.isLoadingRequired = true
        }
    }
    
    //
    // MARK: - Internal Methods
    //
    @IBAction func searchButton(_ sender: Any) {
        RecipeDataManager.shared.removeOnlineList()
    }
    
    @IBAction func addIngredient(_ sender: Any) {
        didTapAdd()
    }
    
    @IBAction func clearIngredientsList(_ sender: Any) {
        didTapClear()
    }

    //
    // MARK: - Private Methods
    //
    private func didTapClear() {
        RequestIngredients.shared.clearIngredientsList()
        ingredientTextField.text = ""
        tableView.reloadData()
    }
    
    private func didTapAdd() {
        if !ingredientTextField.text!.isEmpty {
            if let newIngredient = ingredientTextField.text {
            RequestIngredients.shared.ingredientsList.append(newIngredient)
                print(RequestIngredients.shared.ingredientsList)
            ingredientTextField.text = ""
            tableView.reloadData()
            }
        }
    }
}

//
// MARK: - TableView Data Source
//
extension IngredientsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            RequestIngredients.shared.deleteIngredient(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        let ingredient = RequestIngredients.shared.ingredientsList[indexPath.row]
        cell.textLabel?.text = ingredient.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RequestIngredients.shared.ingredientsList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
