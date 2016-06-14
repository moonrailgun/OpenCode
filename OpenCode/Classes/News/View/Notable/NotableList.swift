//
//  NotableList.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/14.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class NotableList: UIView, UITableViewDataSource, UITableViewDelegate {
    let NOTABLE_CELL_ID = "notable"
    
    var controller:UIViewController?
    lazy var tableView:UITableView = UITableView(frame: self.bounds, style: .Plain)
    var data:JSON?
    
    init(frame: CGRect, controller:UIViewController?){
        super.init(frame:frame)
        
        self.controller = controller
        
        initView()
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        tableView.dataSource = self
        tableView.delegate = self
        self.addSubview(tableView)
    }
    
    func initData(){
        Github.getNotableList(nil) { (data:AnyObject?) in
            if let d = data{
                self.data = JSON(d)
                OperationQueueHelper.operateInMainQueue({ 
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = data{
            return self.data!.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(NOTABLE_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: NOTABLE_CELL_ID)
            cell?.accessoryType = .DisclosureIndicator
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
    }
}
