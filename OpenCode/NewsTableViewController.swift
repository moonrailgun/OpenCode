//
//  NewsTableViewController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-23.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableView , UITableViewDataSource, UITableViewDelegate{
    let TAG_CELL_LABEL = 1
    var dataArr = ["1","2","3"]
    
    required init(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: AnyObject! = tableView.dequeueReusableCellWithIdentifier("newscell")
        
        var label = cell!.viewWithTag(TAG_CELL_LABEL) as UILabel
        label.text = dataArr[indexPath.row]
        
        return cell as UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("选中了\(indexPath.row)行数据")
    }
}
