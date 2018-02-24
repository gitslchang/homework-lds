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
    func didReceiveError(statusCode: Int, error: String) {
        print(error)
    }
}

class DirectoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var affiliationLabel: UILabel!
    @IBOutlet weak var loadingImageLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var indexPath: IndexPath!
    var tableView: UITableView!
    var sentientBeing: SentientBeing!
    
    var api: DirectoryApiController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        api = DirectoryApiController(delegate: self)
        
        nameLabel.textColor = DirectoryColor.mainTitleText
        affiliationLabel.textColor = DirectoryColor.subtitleText
        loadingImageLabel.textColor = DirectoryColor.subtitleText
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        
    }

    func setCellData(tableView: UITableView, indexPath: IndexPath, sentientBeing: SentientBeing) {
        self.indexPath = indexPath
        self.tableView = tableView
        self.sentientBeing = sentientBeing
        
        nameLabel.text = sentientBeing.fullNameDisplay()
        affiliationLabel.text = sentientBeing.affiliationDisplay()
        
        if let url = sentientBeing.pictureUrl {
            api.getImageData(path: url, completionHandler: handleImageDataResponse(_:))
        } else {
            loadingImageLabel.text = "No image"
        }
        
    }
    
    func handleImageDataResponse(_ data: Data) {
        // in real app could store image in cache, but keeping it simple
        let image = UIImage(data: data)
    
        DispatchQueue.main.async(execute: {
            // update cell with loaded image
            if let cellToUpdate = self.tableView.cellForRow(at: self.indexPath) as? DirectoryTableViewCell {
                cellToUpdate.profileImageView.image = image
                cellToUpdate.loadingImageLabel.isHidden = true
            }
        })
    }
    
    

}
