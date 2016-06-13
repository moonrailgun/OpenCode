//
//  SettingsController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/8.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {

    let SETTING_CELL_ID = "setting"
    
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
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let arr = [2,1]
        return arr[section]
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(SETTING_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: SETTING_CELL_ID)
            cell?.accessoryType = .DisclosureIndicator
        }
        
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                cell?.textLabel?.text = "授权管理"
            }else if(indexPath.row == 1){
                cell?.textLabel?.text = "退出账户"
                cell?.textLabel?.textColor = UIColor.alizarinFlatColor()
            }
        }
        
        if(indexPath.section == 1){
            if(indexPath.row == 0){
                cell?.textLabel?.text = "关于"
            }
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                print("授权管理")
                
                let alert = UIAlertController(title: "正在进行敏感操作", message: "请重新输入你的账户和密码，来确保本次操作是由账户所有者本人执行", preferredStyle: .Alert)
                alert.addTextFieldWithConfigurationHandler({ (textField:UITextField) in
                    textField.placeholder = "帐号"
                })
                alert.addTextFieldWithConfigurationHandler({ (textField:UITextField) in
                    textField.placeholder = "密码"
                    textField.secureTextEntry = true
                })
                alert.addAction(UIAlertAction(title: "取消", style: .Default, handler: nil))
                alert.addAction(UIAlertAction(title: "确定", style: .Destructive, handler: { (action:UIAlertAction) in
                    let username = alert.textFields?.first?.text
                    let password = alert.textFields?.last?.text
                    print("暂未处理。账户名\(username!)")//TODO
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else if(indexPath.row == 1){
                print("退出账户")
                
                let alert = UIAlertController(title: "登出", message: "是否要登出账户？", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "取消", style: .Default, handler: nil))
                alert.addAction(UIAlertAction(title: "确定", style: .Destructive, handler: { (action:UIAlertAction) in
                    Github.logout({ () -> Void? in
                        OperationQueueHelper.operateInGlobalQueue({
                            self.navigationController?.popToRootViewControllerAnimated(true)
                        })
                    })
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        if(indexPath.section == 1){
            if(indexPath.row == 0){
                //关于
                print("关于")
                self.navigationController?.pushViewController(AboutController(), animated: true)
            }
        }
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
