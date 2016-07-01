//
//  TrendingView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/30.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class TrendingView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let TRENDING_CELL_ID = "trending"
    lazy var tableView:UITableView = UITableView(frame: self.bounds, style: .Plain)
    var data:JSON?
    var controller:UIViewController?
    var currentMaxPage = 1

    init(frame: CGRect, controller:UIViewController?) {
        super.init(frame:frame)
        
        self.controller = controller
        
        initView()
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        tableView.registerNib(UINib(nibName: "SearchRepoCell", bundle: nil), forCellReuseIdentifier: TRENDING_CELL_ID)
        tableView.rowHeight = 130
        tableView.dataSource = self
        tableView.delegate = self
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.currentMaxPage += 1
            self.addonData(self.currentMaxPage)
        })
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
    
    func addonData(page:Int){
        Github.getGithubTrending(page) { (data:AnyObject?) in
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(TRENDING_CELL_ID)
        
        if(cell == nil){
            cell = SearchRepoCell(style: .Default, reuseIdentifier: TRENDING_CELL_ID)
            cell?.accessoryType = .DisclosureIndicator
        }
        
        if(data != nil){
            let item = data![indexPath.row]
            (cell as! SearchRepoCell).setData(item)
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
        let item = self.data![indexPath.row]
        if let repoFullName = item["full_name"].string{
            ProgressHUD.show()
            Github.getRepoInfo(repoFullName, completionHandler: { (data:AnyObject?) in
                OperationQueueHelper.operateInMainQueue({
                    ProgressHUD.dismiss()
                    let controller = RepoDetailController()
                    controller.repoDetailData = data
                    self.controller?.navigationController?.pushViewController(controller, animated: true)
                })
            })
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
