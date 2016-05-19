//
//  UserInfoController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/18.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserInfoController: UIViewController, UITableViewDataSource {
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
        print(userInfo)
        
        self.headerView = UserInfoHeaderView()
        headerView?.setData(UIImage(data: NSData(contentsOfURL: NSURL(string: userInfo.avatarUrl)!)!)!, name: userInfo.name)
        
        //列表
        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView?.dataSource = self
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
