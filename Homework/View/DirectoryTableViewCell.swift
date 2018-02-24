//
//  DirectoryTableViewCell.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import UIKit

extension DirectoryTableViewCell: ApiControllerProtocol {
    func didReceiveResults() {}
    func didReceiveError() {
        print("error")
    }
}

class DirectoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var affiliationLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var indexPath: IndexPath!
    var tableView: UITableView!
    var sentientBeing: String!
    
    var api: DirectoryApiController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        api = DirectoryApiController(delegate: self)
        
        nameLabel.textColor = DirectoryColor.mainTitleText
        affiliationLabel.textColor = DirectoryColor.subtitleText
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        
    }

    func setCellData(tableView: UITableView, indexPath: IndexPath, sentientBeing: String) {
        self.indexPath = indexPath
        self.tableView = tableView
        
        api.getImageData(path: sentientBeing, completionHandler: handleImageDataResponse(_:))
    }
    
    func handleImageDataResponse(_ data: Data) {
        let image = UIImage(data: data)
    
        DispatchQueue.main.async(execute: {
            if let cellToUpdate = self.tableView.cellForRow(at: self.indexPath) as? DirectoryTableViewCell {
                cellToUpdate.profileImageView.image = image
            }
        })
    }
    
    

}
