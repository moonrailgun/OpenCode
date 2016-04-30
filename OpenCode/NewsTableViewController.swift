//
//  NewsTableViewController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-23.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableView , UITableViewDataSource, UITableViewDelegate{
    let TAG_CELL_LABEL_EVENT = 1
    let TAG_CELL_LABEL_TIME = 2
    let TAG_CELL_LABEL_DESC = 3
    
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
        let data = dataArr[indexPath.row]
        
        var eventLabel = cell!.viewWithTag(TAG_CELL_LABEL_EVENT) as UILabel
        eventLabel.text = data.type
        
        var timeLabel = cell!.viewWithTag(TAG_CELL_LABEL_TIME) as UILabel
        timeLabel.text = data.time
        
        var descLabel = cell.viewWithTag(TAG_CELL_LABEL_DESC) as UILabel
        descLabel.text = generateDescriptionStr(data.type,username: data.actor.objectForKey("login") as String, repositoryName: data.repo.objectForKey("name") as String)
        
        return cell as UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("选中了\(indexPath.row)行数据")
        println(dataArr[indexPath.row].repo)
        
    }
    
    //更新事件列表
    func updateEventList(){
        Github.getEvents({events, error in
            for _event in events {
                var time = Github.parseGithubTime(_event.time)
                let event = GithubEvent(type: _event.type, time: time, actor: _event.actor, repo: _event.repo)
                
                self.dataArr.append(event)
            }
            
            OperationQueueHelper.operateInMainQueue({ () -> Void in
                self.reloadData()
            })
        })
    }
    
    private func generateDescriptionStr(eventType:String ,username:String, repositoryName:String) -> String{
        var str:String = ""
        let type = Github.parseEventType(eventType)
        
        var desc = ""
        switch type{
        case .CreateEvent:desc = "创建了一个项目"
        case .ForkEvent:desc = "创建了一个分支"
        case .GollumEvent:desc = "建立了一条wiki"
        case .IssueCommentEvent:desc = "提交了一条问题"
        case .PullRequestEvent:desc = "发送了一条拉取请求"
        case .PushEvent:desc = "提交了一些代码"
        case .Unknow:desc = "进行了一些操作"
        case .WatchEvent:desc = "观察了项目"
        case .DeleteEvent:desc = "进行了删除操作"
        }
        
        str = "\(username) \(desc)到 \(repositoryName)"
        
        return str
    }
}
