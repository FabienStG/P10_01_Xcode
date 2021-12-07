//
//  OnlineTableViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 26/11/2021.
//

import UIKit

//
// MARK: - Online Tableview Controller
//

/// Inerhit from ResultTableView Controller and manage the online results
class OnlineTableViewController: ResultTableViewController {
    //
    // MARK: - Variables And Properties
    //
    var isLoadingRequired = true
    var mode: Mode = .online

    //
    // MARK: - View Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switchOnlineResult()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataManager.setMode(mode: mode)
        tableView.reloadData()
        }
    
    //
    // MARK: - Private Methods
    //
    private func switchOnlineResult() {
        if isLoadingRequired {
            showResult(.initial)
            isLoadingRequired = false
        } else {
            dataManager.showPreviousOnlineRequest()
            tableView.reloadData()
        }
    }
}

//
// MARK: - Scroll View
//
extension OnlineTableViewController {
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isLoadingStarted = true
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isLoadingStarted = false
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight -  scrollView.frame.height {
            if dataManager.paginationFinished() && !isLoadingStarted {
            isLoadingStarted = true
            showResult(.following)
            }
        }
    }
}

