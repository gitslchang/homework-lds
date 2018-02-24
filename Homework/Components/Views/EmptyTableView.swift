//
//  EmptyTableView.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import UIKit

class EmptyTableView: UIView {

    
    @IBOutlet weak var noDataText: UILabel!
    @IBOutlet weak var noDataIcon: UIImageView!
    
    @IBOutlet weak var noDataIconTopConstraint: NSLayoutConstraint!
    
    func initView(imageName: String, text: String) {
        self.backgroundColor = TableColor.defaultBackgroundColor
        noDataText.textColor = DirectoryColor.mainTitleText
        
        if (imageName.count > 0) {
            noDataIcon.image = UIImage(named: imageName)
        } else {
            noDataIcon.isHidden = true
            noDataIconTopConstraint.constant = 5
        }
        
        noDataText.text = text
        noDataText.sizeToFit()
    }
}
