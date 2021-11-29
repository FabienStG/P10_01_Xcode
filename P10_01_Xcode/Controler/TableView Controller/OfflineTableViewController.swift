//
//  OfflineTableViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 26/11/2021.
//

import UIKit
import DZNEmptyDataSet

class OfflineTableViewController: ResultTableViewController {

    var mode: Mode = .offline
    let tungsten: UIColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
        showResult(.initial)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        RecipeDataManager.shared.setMode(mode: mode)
        tableView.reloadData()
    }
}

extension OfflineTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "You haven't any favorite yet."
        let attribs = [
            NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18.0)!,
            NSAttributedString.Key.foregroundColor: self.tungsten
        ]
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "You can add a recipe to your favorite with the star on the recipe page."
        let para = NSMutableParagraphStyle()
        para.lineBreakMode = NSLineBreakMode.byWordWrapping
        para.alignment = NSTextAlignment.center
        
        let attribs = [
            NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 14.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.paragraphStyle: para]
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
    }
}
