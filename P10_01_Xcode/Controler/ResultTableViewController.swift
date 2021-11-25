//
//  ResultTableViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 03/11/2021.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    var mode: Mode = .offline

    var isLoadingStarted = false
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = activityIndicator
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(1)
        RecipeDataManager.shared.setMode(mode: mode)
        print(2)
        showResult(.initial)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ResultTableViewController {
            mode = .offline
        }
    }

    private func showResult(_ requestStatus: RequestStatus) {
        activityIndicator.startAnimating()
        RecipeDataManager.shared.getRecipies(requestStatus, successHandler: {
            self.tableView.reloadData()
            self.endLoading()
        }, errorHandler: { error in
            self.presentAlert(title: "Error", message: error)
            self.tableView.reloadData()
            self.endLoading()
        })
    }
        
    private func endLoading() {
        activityIndicator.stopAnimating()
        isLoadingStarted = false
    }
}

extension ResultTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeDataManager.shared.displayableList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let recipe = RecipeDataManager.shared.displayableList[indexPath.row]
        cell.configure(withRecipe: recipe)
        return cell
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        RecipeDataManager.shared.setSelectedRecipe(RecipeDataManager.shared.displayableList[indexPath.row])
        return indexPath
    }
}

extension ResultTableViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight -  scrollView.frame.height {
            if NetworkingClient.shared.paginationFinished && !isLoadingStarted {
            isLoadingStarted = true
            showResult(.following)
            }
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isLoadingStarted = true
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isLoadingStarted = false
    }
}
