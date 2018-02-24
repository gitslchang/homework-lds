//
//  DirectoryTableViewCell.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import UIKit

class DirectoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var affiliationLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.textColor = DirectoryColor.mainTitleText
        affiliationLabel.textColor = DirectoryColor.subtitleText
    }


}
