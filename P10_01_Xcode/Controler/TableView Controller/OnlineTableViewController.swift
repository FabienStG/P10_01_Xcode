//
//  OnlineTableViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 26/11/2021.
//

import UIKit

class OnlineTableViewController: ResultTableViewController {
    
    var isLoadingRequired = true
    var mode: Mode = .online

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switchOnlineResult()
    }
    
    func switchOnlineResult() {
        if isLoadingRequired {
            showResult(.initial)
            isLoadingRequired = false
        } else {
            dataManager.showPreviousOnlineRequest()
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataManager.setMode(mode: mode)
        tableView.reloadData()
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

