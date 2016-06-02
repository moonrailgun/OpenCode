//
//  MyController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/31.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class MyController: UIViewController {
    
    lazy var loginView:MyLoginView = MyLoginView(frame: self.view.bounds)
    lazy var profileView:MyProfileView = MyProfileView(frame: self.view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.title = "个人中心"
        
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
