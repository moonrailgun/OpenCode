//
//  CommitDetailController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/12.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommitDetailController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    let COMMIT_DETAIL_CELL_ID = "commit"
    lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .Grouped)
    let header:CommitDetailHeaderView = CommitDetailHeaderView()
    var commitData:JSON?
    var sha:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.tableHeaderView = header
        self.view.addSubview(tableView)
    }
    
    func initData(){
        if let data = commitData{
            self.sha = data["sha"].string!
            let message = data["commit"]["message"].string!
            let commentCount = data["commit"]["comment_count"].int!
            let committerDate = data["commit"]["committer"]["date"].string!
            let committerName = data["commit"]["committer"]["name"].string!
            let committerEmail = data["commit"]["committer"]["email"].string!
            let committerAvatar = data["committer"]["avatar_url"].string
            print(data)
            
            var committerAvatarUrl:NSURL?
            if(committerAvatar != nil){
                committerAvatarUrl = NSURL(string: committerAvatar!)
            }else{
                committerAvatarUrl = nil
            }
            
            header.setData(committerAvatarUrl, name: committerName, commentNum: commentCount)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(COMMIT_DETAIL_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: COMMIT_DETAIL_CELL_ID)
            
            if(indexPath.section == 0){
                if(indexPath.row == 0){
                    cell?.textLabel?.text = "查看评论"
                }
            }
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                //查看评论
                if(self.sha != ""){
                    ProgressHUD.show()
                    Github.customRequest(commitData!["comments_url"].string!, isPublic: true, completionHandler: { (data:AnyObject?) in
                        OperationQueueHelper.operateInMainQueue({
                            print(data)
                            ProgressHUD.dismiss()
                        })
                    })
                }
            }
        }
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
