//
//  UserListController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/16.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class OldUserListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView: UITableView = UITableView()
    var userListData:AnyObject?
    var userList = [UserBaseInfo]()
    
    let USER_CELL_ID = "user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNavItem()
        self.initView()
        self.initData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initNavItem(){
        self.title = "用户列表"
    }
    
    func initView(){
        self.view.backgroundColor = GlobalDefine.defineBackgroundColor
        
        self.tableView.frame = self.view.bounds
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //self.tableView.registerClass(UserCell.self, forCellReuseIdentifier: self.USER_CELL_ID)
        self.tableView.registerNib(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: self.USER_CELL_ID)
        self.tableView.rowHeight = 48
        
        self.view.addSubview(self.tableView)
    }
    
    func initData(){
        let data = getDataJson()
        
        for d in data.array!{
            let info = UserBaseInfo(data: d.object)
            self.userList.append(info)
        }
    }
    
    func getDataJson()->JSON{
        if let d = self.userListData{
            let json = JSON(d)
            return json
        }else{
            return []
        }
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return getDataJson().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(USER_CELL_ID, forIndexPath: indexPath)
        if let c = cell as? UserCell{
            let index = indexPath.row
            let data = self.userList[index]
            c.setData(UIImage(data: NSData(contentsOfURL: NSURL(string: data.avatarUrl)!)!)!, name: data.login)//TODO 需要懒加载
        }

        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("点击了第\(indexPath.row)项")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
