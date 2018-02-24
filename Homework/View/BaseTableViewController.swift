//
//  BaseTableViewController.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = DirectoryColor.navigationTint
        self.navigationController?.navigationBar.tintColor = UIColor.white 
    }

    

}
