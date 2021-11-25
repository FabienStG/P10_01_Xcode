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
        tableView.reloadData()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !NetworkManager.shared.checkIngredient() {
            presentAlert(title: "Error", message: "Write ingredient first")
            return false
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let successVS = segue.destination as? ResultTableViewController {
            if segue.identifier == "resultSegue" {
                successVS.mode = .online
                successVS.isReloadRequired = true
            } else {
                successVS.mode = .offline
                successVS.isReloadRequired = false
            }
        }
    }
    
    //
    // MARK: - Internal Methods
    //
    @IBAction func searchButton(_ sender: Any) {
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
        NetworkManager.shared.clearIngredientsList()
        ingredientTextField.text = ""
        tableView.reloadData()
    }
    
    private func didTapAdd() {
        if !ingredientTextField.text!.isEmpty {
            if let newIngredient = ingredientTextField.text {
            NetworkManager.shared.ingredientsList.append(newIngredient)
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
            NetworkManager.shared.deleteIngredient(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        let ingredient = NetworkManager.shared.ingredientsList[indexPath.row]
        cell.textLabel?.text = ingredient.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NetworkManager.shared.ingredientsList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
