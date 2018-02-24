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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = DirectoryTableViewController.myTitle
        
        TableHelper.removeEmptyCellsFromTableBottom(tableView)
        tableView.backgroundView = getNoTableDataView()
        
        dataProvider = DictionaryDataProvider(delegate: self)
    }

    func loadData() {
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DirectoryTableViewController.cellIdentifier, for: indexPath) as! DirectoryTableViewCell

        cell.setCellData(tableView: tableView, indexPath: indexPath, sentientBeing: "https://edge.ldscdn.org/mobile/interview/02.jpg")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
