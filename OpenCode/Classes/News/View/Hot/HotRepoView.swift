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
    var controller:UIViewController?
    
    var currentMaxPage = 1
    
    init(frame: CGRect, controller:UIViewController?) {
        super.init(frame: frame)

        self.controller = controller
        
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
                    let header = UILabel(frame: CGRectMake(0,0,self.bounds.width,24))
                    header.text = "共\(json["total_count"].int!)个热门项目"
                    header.textColor = UIColor.whiteColor()
                    header.backgroundColor = UIColor.alizarinFlatColor()
                    header.textAlignment = .Center
                    header.font = UIFont.systemFontOfSize(14)
                    self.tableView.tableHeaderView = header
                    
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
        tableView.delegate = self
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
        let item = self.hotRepoData![indexPath.row]
        if let repoFullName = item["full_name"].string{
            Github.getRepoInfo(repoFullName, completionHandler: { (data:AnyObject?) in
                let controller = RepoDetailController()
                controller.repoDetailData = data
                OperationQueueHelper.operateInMainQueue({ 
                    self.controller?.navigationController?.pushViewController(controller, animated: true)
                })
            })
        }
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
