//
//  TableUtil.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import UIKit

struct TableNib {
    static let emptyTable = "EmptyTableView"
}

struct TableColor {
    static let defaultBackgroundColor = UIColor.fromHex(0xf0eff5)
}

class TableHelper: NSObject {
    class func getEmptyTableView(iconName: String, text: String) -> EmptyTableView {
        let emptyView = Bundle.main.loadNibNamed(TableNib.emptyTable, owner: self, options: nil)?[0] as! EmptyTableView
        emptyView.initView(imageName: iconName, text: text)
        return emptyView
    }
    
    class func removeEmptyCellsFromTableBottom(tableView: UITableView) {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.backgroundColor = TableColor.defaultBackgroundColor
    }
}
