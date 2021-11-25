//
//  IngredientsViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 03/11/2021.
//

import UIKit
import Alamofire

class IngredientsViewController: UIViewController {
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    @IBAction func searchButton(_ sender: Any) {
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !NetworkingClient.shared.checkIngredient() {
            presentAlert(title: "Error", message: "Write ingredient first")
            return false
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let successVS = segue.destination as? ResultTableViewController {
            if segue.identifier == "resultSegue" {
                successVS.mode = .online
                //successVS.isLoadingRequired = true
                print("Online")
            } else {
                successVS.mode = .offline
                //successVS.isLoadingRequired = true
            print("Offline")
            }
        }
    }
    
    /*func disableButton() {
        if NetworkingClient.shared.checkIngredient() {
            searchButton.isEnabled = false
        }
    }*/
    
    private func didTapAdd() {
        if !ingredientTextField.text!.isEmpty {
            if let newIngredient = ingredientTextField.text {
            NetworkingClient.shared.ingredientsList.append(newIngredient)
            ingredientTextField.text = ""
            tableView.reloadData()
            }
        }
    }
    
    private func didTapClear() {
        NetworkingClient.shared.clearIngredientsList()
        ingredientTextField.text = ""
        tableView.reloadData()
    }
    
    @IBAction func addIngredient(_ sender: Any) {
        didTapAdd()
    }
    
    @IBAction func clearIngredientsList(_ sender: Any) {
        didTapClear()
    }
}

extension IngredientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NetworkingClient.shared.ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        let ingredient = NetworkingClient.shared.ingredientsList[indexPath.row]
        cell.textLabel?.text = ingredient.description
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            NetworkingClient.shared.deleteIngredient(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
