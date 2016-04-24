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
    let TAG_CELL_LABEL_TIME = 2
    
    var dataArr = [GithubEvent]()
    
    required init(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
        
        updateEventList()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: AnyObject! = tableView.dequeueReusableCellWithIdentifier("newscell")
        
        var label = cell!.viewWithTag(TAG_CELL_LABEL) as UILabel
        label.text = dataArr[indexPath.row].type
        
        var time = cell!.viewWithTag(TAG_CELL_LABEL_TIME) as UILabel
        time.text = dataArr[indexPath.row].time
        
        return cell as UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("选中了\(indexPath.row)行数据")
        println(dataArr[indexPath.row].repo)
    }
    
    func updateEventList(){
        Github.getEvents({events, error in
            
            for event in events {
                println(event)
            }
            
            for index in 0 ... events.count - 1{
                self.dataArr.append(events[index])
            }
            self.reloadData()
        })
    }
}
