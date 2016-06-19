//
//  NotableList.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/14.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class NotableList: UIView, UITableViewDataSource, UITableViewDelegate {
    let NOTABLE_CELL_ID = "notable"
    
    var controller:UIViewController?
    lazy var tableView:UITableView = UITableView(frame: self.bounds, style: .Plain)
    var data:JSON?
    var currentMaxPage = 1
    
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
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.currentMaxPage += 1
            self.addonData(self.currentMaxPage)
        })
        self.addSubview(tableView)
    }
    
    func initData(){
        Github.getNotableList(nil) { (data:AnyObject?) in
            if let d = data{
                let json = JSON(d)
                print("共\(json["total_count"].int!)个github名人")
                let items = json["items"]
                self.data = items
                
                OperationQueueHelper.operateInMainQueue({
                    let header = UILabel(frame: CGRectMake(0,0,self.bounds.width,24))
                    header.text = "共\(json["total_count"].int!)个名人"
                    header.textColor = UIColor.whiteColor()
                    header.backgroundColor = UIColor.peterRiverFlatColor()
                    header.textAlignment = .Center
                    header.font = UIFont.systemFontOfSize(14)
                    self.tableView.tableHeaderView = header
                    
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func addonData(page:Int){
        Github.getNotableList(page) { (data:AnyObject?) in
            if let d = data{
                let json = JSON(d)
                print("加载新数据完毕,加载页码\(page)")
                let items = json["items"]
                
                if(self.data != nil) {
                    var tmp = self.data?.array
                    for i in 0 ... items.count - 1{
                        tmp!.append(items[i])
                    }
                    self.data = JSON(tmp!)
                }
                
                OperationQueueHelper.operateInMainQueue({
                    self.tableView.reloadData()
                    self.tableView.mj_footer.endRefreshing()
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
        
        if(data != nil){
            let item = data![indexPath.row]
            cell?.textLabel?.text = item["login"].string
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
    }
}
