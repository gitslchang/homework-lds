//
//  DirectoryTableViewController.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import UIKit

extension DirectoryTableViewController: DictionaryDataProviderDelegate {
    func updateDictionaryData() {
        loadData()
    }
}

class DirectoryTableViewController: BaseTableViewController {
    
    fileprivate static let cellIdentifier = "infoCell"
    fileprivate static let myTitle = "Sentient Beings"
    
    var dataProvider: DictionaryDataProvider!
    var sentientBeings = [SentientBeing]() {
        didSet {
            let hasData = sentientBeings.count > 0
            tableView.backgroundView?.isHidden = hasData
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = DirectoryTableViewController.myTitle
        
        TableHelper.removeEmptyCellsFromTableBottom(tableView: tableView)
        tableView.backgroundView = getNoTableDataView()
        
        dataProvider = DictionaryDataProvider(delegate: self)
    }

    fileprivate func loadData() {
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentientBeings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DirectoryTableViewController.cellIdentifier, for: indexPath) as! DirectoryTableViewCell
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DirectorySegue.showProfile {
            let destination = segue.destination as! ProfileViewController
            if let cell = sender as? DirectoryTableViewCell {
                destination.sentientBeing = cell.sentientBeing
            }
        }
    }
    

}
