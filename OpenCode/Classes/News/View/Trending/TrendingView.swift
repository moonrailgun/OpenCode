//
//  TrendingView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/30.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class TrendingView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let TRENDING_CELL_ID = "trending"
    lazy var tableView:UITableView = UITableView(frame: self.bounds, style: .Plain)
    var data:JSON?

    override init(frame: CGRect) {
        super.init(frame:frame)
        
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
        Github.getGithubTrending(nil) { (data:AnyObject?) in
            if let d = data{
                let json = JSON(d)
                print("共\(json["total_count"].int!)个近期热门项目")
                let items = json["items"]
                self.data = items
                
                OperationQueueHelper.operateInMainQueue({
                    let header = UILabel(frame: CGRectMake(0,0,self.bounds.width,24))
                    header.text = "共\(json["total_count"].int!)个近期热门项目"
                    header.textColor = UIColor.whiteColor()
                    header.backgroundColor = UIColor.turquoiseFlatColor()
                    header.textAlignment = .Center
                    header.font = UIFont.systemFontOfSize(14)
                    self.tableView.tableHeaderView = header
                    
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(TRENDING_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: TRENDING_CELL_ID)
            cell?.accessoryType = .DisclosureIndicator
        }
        
        if(data != nil){
            let item = data![indexPath.row]
            cell?.textLabel?.text = item["name"].string
        }
        
        return cell!
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
