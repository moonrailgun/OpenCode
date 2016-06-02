//
//  MyController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/31.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyController: UIViewController {
    
    lazy var loginView:MyLoginView = MyLoginView(frame: self.view.bounds)
    //lazy var profileView:MyProfileView = MyProfileView(frame: self.view.frame)
    lazy var profileView:MyProfileView = MyProfileView(frame: CGRectMake(0,-64,self.view.bounds.width,self.view.bounds.height + 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let _:String = Github.getToken() {
            //显示正常页
            initProfileView()
        }else{
            //显示登陆页面
            initLoginView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initLoginView() {
        self.view.addSubview(loginView)
    }
    
    func initProfileView() {
        self.view.addSubview(profileView)
        
        initNav()
        initData()
    }
    
    func initNav(){
        //self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "个人资料", style: .Plain, target: self, action: Selector("showProfileDetail"))
        
    }
    
    func initData(){
        Github.getCurrentUserInfo { (data:AnyObject?) in
            print(JSON(data!))
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
