//
//  EventDetailController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/8/10.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventDetailController: UIViewController {
    
    var data:JSON?
    
    let avatar:UIImageView = UIImageView(frame: CGRectMake(20, 200, 100, 100))
    let name:UILabel = UILabel(frame: CGRectMake(140,220,200,40))
    let date:UILabel = UILabel(frame: CGRectMake(140,260,200,40))
    
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
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(avatar)
        self.view.addSubview(name)
        date.textColor = GlobalDefine.iconGrey
        self.view.addSubview(date)
    }
    
    func initData(){
        if let d = data{
            let type = d["type"].string!
            let date = GithubTime(dateStr: d["created_at"].string!)
            let actor = d["actor"]
            var name = actor["login"].string!
            if let dl = actor["display_login"].string{
                name = dl
            }
            if let avatar = actor["avatar_url"].string{
                self.avatar.sd_setImageWithURL(NSURL(string: avatar))
            }else{
                self.avatar.image = GlobalDefine.defaultAvatar
            }
            
            self.name.text = name
            self.date.text = date.long()
            print(type)
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
