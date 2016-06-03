//
//  NewsEventListView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/29.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class NewsEventListView: UIView, UITableViewDataSource, UITableViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let NEWS_EVENT_CELL_ID = "newsEvent"
    var tableView:UITableView?
    var dataArr:JSON?
    var controller:UIViewController?
    
    init(frame: CGRect, controller:UIViewController?) {
        super.init(frame: frame)

        self.controller = controller
        initView()
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initView(){
        self.tableView = UITableView(frame: self.bounds, style: .Plain)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.rowHeight = 90
        tableView?.registerNib(UINib(nibName: "NewsEventCell", bundle: nil), forCellReuseIdentifier: NEWS_EVENT_CELL_ID)
        self.addSubview(tableView!)
        
        //下拉刷新
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.initData()
        })
    }
    func initData(){
        Github.getEvents { (data:AnyObject?) -> Void in
            let json = JSON(data!)
            self.dataArr = json
            print("github事件 数据加载完毕")
            if json.count > 0{
                OperationQueueHelper.operateInMainQueue({ () -> Void in
                    self.tableView!.reloadData()
                    
                    self.endRefresh()
                })
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let d = dataArr{
            return d.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        
        if let d = dataArr{
            let item = d[indexPath.row]
            
            Github.getRepoInfo(item["repo"]["name"].string!, completionHandler: { (data:AnyObject?) in
                let controller = RepoDetailController()
                controller.repoDetailData = data
                OperationQueueHelper.operateInMainQueue({ 
                    self.controller?.navigationController?.pushViewController(controller, animated: true)
                })
            })
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(NEWS_EVENT_CELL_ID)
        
        if(cell == nil){
            cell = NewsEventCell(style: .Default, reuseIdentifier: NEWS_EVENT_CELL_ID)
        }
        
        if let d = self.dataArr{
            let event = d[indexPath.row]
            
            let type = event["type"].string!
            let username = event["actor"]["login"].string!
            let reponame = event["repo"]["name"].string!
            
            (cell as! NewsEventCell).setData(type, dataStr: Github.parseGithubTime(event["created_at"].string!), userAvatarUrl: event["actor"]["avatar_url"].string!, descText: generateDescriptionStr(type, username: username, repositoryName: reponame))
        }
        
        return cell!
    }
    
    private func generateDescriptionStr(eventType:String ,username:String, repositoryName:String) -> String{
        var str:String = ""
        let type = Github.parseEventType(eventType)
        
        var desc = ""
        switch type{
        case .CreateEvent:desc = "创建了一个项目"
        case .ForkEvent:desc = "创建了一个分支"
        case .GollumEvent:desc = "建立了一条wiki"
        case .IssuesCommentEvent:desc = "提交了一条问题"
        case .PullRequestEvent:desc = "发送了一条拉取请求"
        case .PushEvent:desc = "提交了一些代码"
        case .Unknow:desc = "进行了一些操作"
        case .WatchEvent:desc = "观察了项目"
        case .DeleteEvent:desc = "进行了删除操作"
        }
        
        str = "\(username) \(desc)到 \(repositoryName)"
        
        return str
    }
    
    private func beginRefresh(){
        self.tableView?.mj_header.beginRefreshing()
    }
    
    private func endRefresh(){
        self.tableView?.mj_header.endRefreshing()
    }
}
