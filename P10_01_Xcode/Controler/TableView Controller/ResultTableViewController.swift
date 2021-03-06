//
//  ResultTableViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 03/11/2021.
//

import UIKit
//
// MARK: - Result TableView Controller
//
class ResultTableViewController: UITableViewController {
    //
    // MARK: - Variables And Properties
    //
    var isLoadingStarted = true
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let dataManager = RecipeDataManager.shared()

    //
    // MARK: - View Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = activityIndicator
    }

    //
    // MARK: - Private Methods
    //
    private func endLoading() {
        activityIndicator.stopAnimating()
        isLoadingStarted = false
    }
    
    func showResult(_ requestStatus: RequestStatus) {
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating()
        dataManager.getRecipies(requestStatus, successHandler: {
            self.tableView.reloadData()
            self.endLoading()
        }, errorHandler: { error in
            self.presentAlert(title: "Error", message: error)
            self.tableView.reloadData()
            self.endLoading()
        })
    }
}

//
// MARK: - TableView Data Source
//
extension ResultTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.displayableList.count
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        dataManager.setSelectedRecipe(dataManager.displayableList[indexPath.row])
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let recipe = dataManager.displayableList[indexPath.row]
        cell.configure(withRecipe: recipe)
        return cell
    }
}
