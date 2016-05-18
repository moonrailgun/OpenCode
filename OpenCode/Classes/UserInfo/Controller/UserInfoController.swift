//
//  UserInfoController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/18.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserInfoController: UIViewController {

    var userInfoDate:UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let userInfo = self.userInfoDate{
            print(userInfo.repos_url)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
