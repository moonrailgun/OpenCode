//
//  HotRepoView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/31.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotRepoView: UIView, UITableViewDataSource {
    let HOT_CELL_ID = "hot"
    lazy var tableView:UITableView = UITableView(frame: self.bounds, style: .Plain)
    var hotRepoData:JSON?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(){
        Github.getGithubHotSearch(nil) { (data:AnyObject?) in
            if let d = data{
                let json = JSON(d)
                print(json)
                let items = json["items"]
                self.hotRepoData = items
                
                OperationQueueHelper.operateInMainQueue({
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func initView(){
        tableView.registerNib(UINib(nibName: "SearchRepoCell", bundle: nil), forCellReuseIdentifier: HOT_CELL_ID)
        self.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.hotRepoData != nil){
            return self.hotRepoData!.count
        }else{
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(HOT_CELL_ID)
        
        if(cell == nil){
            cell = SearchRepoCell(style: .Default, reuseIdentifier: HOT_CELL_ID)
        }
        
        if(hotRepoData != nil){
            let item = hotRepoData![indexPath.row]
            (cell as! SearchRepoCell).setData(item)
        }
        
        return cell!
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
