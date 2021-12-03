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
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var clearIngredientButton: UIButton!
    
    //
    // MARK: - View Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTextField.delegate = self
        ingredientTextField.setUnderline()
        setRadius()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
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
        RecipeDataManager.shared().removeOnlineList()
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
    
    private func setRadius() {
        searchButton.layer.cornerRadius = 5.0
        addIngredientButton.layer.cornerRadius = 5.0
        clearIngredientButton.layer.cornerRadius = 5.0
    }

    private func didTapAdd() {
        if !ingredientTextField.text!.isEmpty {
            if let newIngredient = ingredientTextField.text {
            RequestIngredients.shared.ingredientsList.append(newIngredient)
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
        cell.textLabel?.text = "- " + ingredient.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RequestIngredients.shared.ingredientsList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

//
// MARK: - TextField
//
extension IngredientsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingredientTextField.resignFirstResponder()
        return true
    }
}
