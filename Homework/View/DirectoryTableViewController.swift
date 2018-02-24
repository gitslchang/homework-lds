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
        sentientBeings = dataProvider.queryDirectory()
        tableView.reloadData()
    }
}

class DirectoryTableViewController: UITableViewController {
    
    let cellIdentifier = "infoCell"
    let myTitle = "Sentient Beings"
    let noDataMessage = "Important sentient beings of the universe will be displayed here."
    
    var dataProvider: DictionaryDataProvider!
    var sentientBeings = [SentientBeing]() {
        didSet {
            let hasData = sentientBeings.count > 0
            tableView.backgroundView?.isHidden = hasData
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = myTitle
        
        self.navigationController?.navigationBar.barTintColor = DirectoryColor.navigationTint
        self.navigationController?.navigationBar.tintColor = UIColor.white 
        
        TableHelper.removeEmptyCellsFromTableBottom(tableView: tableView)
        tableView.backgroundView = TableHelper.getEmptyTableView(iconName: DirectoryIcon.noDataIcon, text: noDataMessage)
        
        dataProvider = DictionaryDataProvider(delegate: self)
        dataProvider.getSentientBeingsFromApi()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentientBeings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DirectoryTableViewCell
        let being = sentientBeings[indexPath.row]
        cell.setCellData(tableView: tableView, indexPath: indexPath, sentientBeing: being)

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
                destination.profileImage = cell.profileImageView.image
            }
        }
    }
    

}
