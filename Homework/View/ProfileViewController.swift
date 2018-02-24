//
//  ProfileViewController.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var affiliationLabel: UILabel!
    
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var forceSensitiveLabel: UILabel!
    
    var sentientBeing: SentientBeing?
    var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.textColor = DirectoryColor.mainTitleText
        affiliationLabel.textColor = DirectoryColor.subtitleText
        forceSensitiveLabel.textColor = DirectoryColor.forceSensitiveText
        bornLabel.textColor = DirectoryColor.mainTitleText
        birthdateLabel.textColor = DirectoryColor.subtitleText
        
        if let being = sentientBeing {
            nameLabel.text = being.fullNameDisplay()
            affiliationLabel.text = being.affiliationDisplay()
            forceSensitiveLabel.isHidden = !being.forceSensitive
        }
        
        if let image = profileImage {
            profileImageView.image = image
        }
        
    }

    

}
