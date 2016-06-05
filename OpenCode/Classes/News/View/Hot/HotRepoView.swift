//
//  HotRepoView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/31.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class HotRepoView: UIView, UITableViewDataSource, UITableViewDelegate {
    let HOT_CELL_ID = "hot"
    lazy var tableView:UITableView = UITableView(frame: self.bounds, style: .Plain)
    var hotRepoData:JSON?
    
    var currentMaxPage = 1
    
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
                //print(json)
                print("共\(json["total_count"].int!)个热门项目")
                let items = json["items"]
                self.hotRepoData = items
                
                OperationQueueHelper.operateInMainQueue({
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func addonData(page:Int){
        Github.getGithubHotSearch(page) { (data:AnyObject?) in
            if let d = data{
                let json = JSON(d)
                print("加载新数据完毕,加载页码\(page)")
                let items = json["items"]

                if(self.hotRepoData != nil) {
                    var tmp = self.hotRepoData?.array
                    for i in 0 ... items.count - 1{
                        tmp!.append(items[i])
                    }
                    self.hotRepoData = JSON(tmp!)
                }
                
                OperationQueueHelper.operateInMainQueue({
                    self.tableView.reloadData()
                    self.endRefresh()
                })
            }
        }
    }
    
    func initView(){
        tableView.registerNib(UINib(nibName: "SearchRepoCell", bundle: nil), forCellReuseIdentifier: HOT_CELL_ID)
        tableView.rowHeight = 130
        tableView.dataSource = self
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.currentMaxPage += 1
            self.addonData(self.currentMaxPage)
        })
        self.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.hotRepoData != nil) {
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
    }
    
    private func endRefresh(){
        self.tableView.mj_footer.endRefreshing()
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
