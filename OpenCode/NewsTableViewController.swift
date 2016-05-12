//
//  NewsTableViewController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-30.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsTableViewController: UITableViewController {
    let TAG_CELL_LABEL_EVENT = 1
    let TAG_CELL_LABEL_TIME = 2
    let TAG_CELL_LABEL_DESC = 3
    
    //var dataArr = [GithubEvent]()
    var dataArr:JSON?
    
    required init(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)!
        
        updateEventList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if let d = dataArr{
            return d.count
        }else{
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell")! as UITableViewCell
        
        // Configure the cell...
        let data = dataArr![indexPath.row]
        var eventLabel = cell.viewWithTag(TAG_CELL_LABEL_EVENT) as! UILabel
        eventLabel.text = data["type"].string
        
        var timeLabel = cell.viewWithTag(TAG_CELL_LABEL_TIME) as! UILabel
        timeLabel.text = Github.parseGithubTime(data["created_at"].string!)
        
        var descLabel = cell.viewWithTag(TAG_CELL_LABEL_DESC) as! UILabel
        descLabel.text = generateDescriptionStr(data["type"].string!,username: data["actor"]["login"].string!, repositoryName: data["repo"]["name"].string!)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("选中了\(indexPath.row)行数据")
        
        let data = dataArr![indexPath.row]
        //println(data)
        
        Github.customRequest(data["repo"]["url"].string!, isPublic: true) { (data:AnyObject?) -> Void in
            print("数据加载完毕")
            self.performSegueWithIdentifier("showRepositoryDetail", sender: data)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showRepositoryDetail"){
            //跳转到项目详细页面
            var detail = segue.destinationViewController as! RepositoryDetailTableViewController
            detail.repoDetailData = sender
        }
    }
    
    //更新事件列表
    func updateEventList(){
        /*Github.getEvents({events, error in
            for _event in events {
                var time = Github.parseGithubTime(_event.time)
                let event = GithubEvent(type: _event.type, time: time, actor: _event.actor, repo: _event.repo)
                
                self.dataArr.append(event)
            }
            
            OperationQueueHelper.operateInMainQueue({ () -> Void in
                //todo 刷新列表数据
                self.tableView.reloadData()
            })
        })*/
        
        Github.getEvents { (data:AnyObject?) -> Void in
            var json = JSON(data!)
            self.dataArr = json
            print("github事件 数据加载完毕")
            
            OperationQueueHelper.operateInMainQueue({ () -> Void in
                //todo 刷新列表数据
                self.tableView.reloadData()
            })
        }
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
}
