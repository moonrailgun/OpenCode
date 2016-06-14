//
//  UserEventsController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/7.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

//数据来源:https://api.github.com/users/:username/events
class UserEventsController: UIViewController, UITableViewDataSource {
    let USER_EVENT_CELL_ID = "user_event"
    lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .Plain)
    var eventData:JSON = []
    
    var newEvent = [NSIndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        navigationItem.leftBarButtonItem?.title = ""
        
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "NewsEventCell", bundle: nil), forCellReuseIdentifier: USER_EVENT_CELL_ID)
        tableView.rowHeight = 90
        self.view.addSubview(tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(USER_EVENT_CELL_ID)
        
        if(cell == nil){
            cell = NewsEventCell(style: .Default, reuseIdentifier: USER_EVENT_CELL_ID)
            cell?.accessoryType = .DisclosureIndicator
        }
        
        if(eventData.count > 0){
            let data = self.eventData[indexPath.row]
            if(data != []){
                (cell as! NewsEventCell).setData(data["type"].string!, dateStr: data["created_at"].string!, userAvatarUrl: data["actor"]["avatar_url"].string!, descText: generateEventDesc(data))
            }
            
            
            if(GithubTime(dateStr: data["created_at"].string!).getIntervalSecond() < 24 * 60 * 60 && !newEvent.contains(indexPath)){
                //一天内的新事件
                newEvent.append(indexPath)
                cell?.addSubview(NewBadge(frame: CGRectMake(cell!.frame.width - 10,0,10,10)))
                print(cell!.frame.width)
            }
        }
        
        return cell!
    }
    
    func generateEventDesc(data:JSON) -> String{
        var descMsg = ""//描述文本
        let type = data["type"].string!
        if(type == "PushEvent"){
            if let commits = data["payload"]["commits"].array{
                for commit in commits{
                    if(descMsg != ""){
                        descMsg += "------"
                    }
                    descMsg += commit["message"].string!
                }
            }
        }else if(type == "WatchEvent"){
            descMsg += data["payload"]["action"].string!
        }else{
            descMsg += type
        }
        
        return descMsg
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
