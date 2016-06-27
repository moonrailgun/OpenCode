//
//  UserInfoController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/18.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserInfoController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    let USERINFO_CELL_ID = "userInfoCell"
    var userInfoDate:UserInfo?
    var tableView:UITableView?
    var headerView:UserInfoHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let userInfo = self.userInfoDate{
            initView(userInfo)
        }else{
            print("没有获取到数据")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseData(data:AnyObject) {
        self.userInfoDate = UserInfo(data: data)
    }
    
    func initView(userInfo:UserInfo){
        self.headerView = UserInfoHeaderView()
        headerView?.setData(UIImage(data: NSData(contentsOfURL: NSURL(string: userInfo.avatarUrl)!)!)!, name: userInfo.name, followersNum: userInfo.followers, followingNum: userInfo.following)
        
        //列表
        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.tableHeaderView = self.headerView
        self.view.addSubview(self.tableView!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(self.USERINFO_CELL_ID)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: self.USERINFO_CELL_ID)
            cell?.accessoryType = .DisclosureIndicator
        }
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "事件"
        case 1:
            cell?.textLabel?.text = "组织"
        case 2:
            cell?.textLabel?.text = "项目"
        case 3 :
            cell?.textLabel?.text = "Gists"
        default:
            break
        }
        
        return cell!
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(self.userInfoDate != nil){
            let username = self.userInfoDate!.login
            if(indexPath.section == 0){
                switch indexPath.row {
                case 0:
                    print("事件")
                    ProgressHUD.show()
                    Github.getUserEvents(username, completionHandler: { (data:AnyObject?) in
                        if let d = data{
                            let json = JSON(d)

                            OperationQueueHelper.operateInMainQueue({ 
                                ProgressHUD.dismiss()
                                let controller = UserEventsController()
                                controller.eventData = json
                                self.navigationController?.pushViewController(controller, animated: true)
                            })
                        }
                    })
                case 1:
                    print("组织")
                    ProgressHUD.show()
                    Github.getUserOrgs(username, completionHandler: { (data:AnyObject?) in
                        if let d = data{
                            let json = JSON(d)
                            
                            OperationQueueHelper.operateInMainQueue({ 
                                ProgressHUD.dismiss()
                                let controller = OrgsListController()
                                controller.data = json.arrayValue
                                self.navigationController?.pushViewController(controller, animated: true)
                            })
                        }
                    })
                case 2:
                    print("项目")
                    ProgressHUD.show()
                    Github.getUserRepos(username, completionHandler: { (data:AnyObject?) in
                        if let d = data{
                            let json = JSON(d)
                            
                            OperationQueueHelper.operateInMainQueue({
                                ProgressHUD.dismiss()
                                let controller = RepoListController()
                                controller.repositoryDataList = json
                                self.navigationController?.pushViewController(controller, animated: true)
                            })
                        }
                    })
                case 3:
                    print("gists")
                    Github.getUserGists(username, completionHandler: { (data:AnyObject?) in
                        if let d = data{
                            let json = JSON(d)
                            print(json)
                        }
                    })
                default:
                    break
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
