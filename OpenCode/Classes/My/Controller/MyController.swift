//
//  MyController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/31.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON
import LTNavigationBar

class MyController: UIViewController, UITableViewDelegate {
    
    lazy var loginView:MyLoginView = MyLoginView(frame: self.view.bounds, controller:self)
    //lazy var profileView:MyProfileView = MyProfileView(frame: self.view.frame)
    lazy var profileView:MyProfileView = MyProfileView(frame: CGRectMake(0,-64,self.view.bounds.width,self.view.bounds.height + 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideNav()
        if let _:String = Github.getToken() {
            //显示正常页
            initProfileView()
        }else{
            //显示登陆页面
            initLoginView()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        hideNav()
        if let _:String = Github.getToken() {
            //显示正常页
            initProfileView()
        }else{
            //显示登陆页面
            initLoginView()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        showNav()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initLoginView() {
        self.view.removeAllSubview()
        self.view.addSubview(loginView)
    }
    
    func initProfileView() {
        self.view.removeAllSubview()
        profileView.tableView.delegate = self
        self.view.addSubview(profileView)
        
        initData()
    }
    
    func initNav(){
        //self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "个人资料", style: .Plain, target: self, action: Selector("showProfileDetail"))
    }
    
    func hideNav(){
        self.navigationController?.navigationBar.lt_setElementsAlpha(0)
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clearColor())
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func showNav(){
        self.navigationController?.navigationBar.lt_reset()
    }
    
    func initData(){
        
    }
    
    //我的档案 － 代理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                print("我的事件")
                if let username = self.profileView.userInfo["login"].string{
                    ProgressHUD.show()
                    Github.getUserEvents(username, completionHandler: { (data:AnyObject?) in
                        if let d = data{
                            let controller = UserEventsController()
                            controller.eventData = JSON(d)
                            
                            ProgressHUD.dismiss()
                            OperationQueueHelper.operateInMainQueue({ 
                                self.navigationController?.pushViewController(controller, animated: true)
                            })
                        }
                    })
                }
            }
        }
        
        if(indexPath.section == 1){
            if(indexPath.row == 0){
                print("我的项目")
                ProgressHUD.show()
                Github.getCurrentUserRepositories({ (data:AnyObject?) in
                    let controller = MyRepoController(style: .Plain)
                    controller.repositoryDataList = JSON(data!)
                    
                    OperationQueueHelper.operateInMainQueue({
                        ProgressHUD.dismiss()
                        self.navigationController?.pushViewController(controller, animated: true)
                    })
                })
            }else if(indexPath.row == 1){
                print("我的收藏")
                ProgressHUD.show()
                Github.getCurrentUserStarred({ (data:AnyObject?) in
                    let controller = MyRepoController(style: .Plain)
                    controller.repositoryDataList = JSON(data!)
                    
                    OperationQueueHelper.operateInMainQueue({
                        ProgressHUD.dismiss()
                        self.navigationController?.pushViewController(controller, animated: true)
                    })
                })
            }else if(indexPath.row == 2){
                print("我的粉丝")
                ProgressHUD.show()
                Github.getCurrentUserFollowers({ (data:AnyObject?) in
                    let controller = UserListController()
                    controller.userListData = data
                    
                    OperationQueueHelper.operateInMainQueue({
                        ProgressHUD.dismiss()
                        self.navigationController?.pushViewController(controller, animated: true)
                    })
                })
            }else if(indexPath.row == 3){
                print("我的关注")
                ProgressHUD.show()
                Github.getCurrentUserFollowing({ (data:AnyObject?) in
                    let controller = UserListController()
                    controller.userListData = data
                    
                    OperationQueueHelper.operateInMainQueue({
                        ProgressHUD.dismiss()
                        self.navigationController?.pushViewController(controller, animated: true)
                    })
                })
            }
        }else if(indexPath.section == 2){
            if(indexPath.row == 0){
                print("设置")
                let controller = SettingsController(style: .Grouped)
                self.navigationController?.pushViewController(controller, animated: true)
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
