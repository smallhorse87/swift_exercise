//
//  UITableView+Extension.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/2.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

extension String {
    public var Lenght:Int {
        get{
            return self.count;
        }
    }
}

/**
 向tableView 注册UITableViewCell
 
 - parameter tableView: tableView
 - parameter cell: 要注册的类名
 */

func regClass (_ tableView:UITableView, cell:AnyClass)->Void {
    tableView.register(cell, forCellReuseIdentifier: "\(cell)")
}

/**
 从tableView缓存中取出对应类型的Cell
 
 - parameter tableView: tableView
 - parameter cell:  要返回的Cell类型
 - parameter indexPath: 位置
 */
func getCell<T: UITableViewCell> (_ tableView:UITableView, cell: T.Type, indexPath:IndexPath) -> T
{
    return tableView.dequeueReusableCell(withIdentifier: "\(cell)", for: indexPath) as! T
}

extension UITableView {
    func v2_scrollToBottom() {
        let section = self.numberOfSections - 1
        let row = self.numberOfRows(inSection: section) - 1
        if section < 0 || row < 0 {
            return
        }
        
        let path = IndexPath(row: row, section: section)
        self.scrollToRow(at: path, at: .top, animated: false)
    }

}
