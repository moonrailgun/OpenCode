//
//  OrgsDetailHeaderView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/27.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrgsDetailHeaderView: UIView {

    lazy var headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 180))
    var avatar:UIImageView?
    var name:UILabel?
    var desc: UILabel?
    var followers:RepoInfoView?
    var following:RepoInfoView?
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 230))
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func initView(){
        headerView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        
        self.avatar = UIImageView(frame: CGRect(x: headerView.frame.width/2-50, y: 10, width: 100, height: 100))
        headerView.addSubview(avatar!)
        
        self.name = UILabel(frame: CGRect(x: 0, y: 110, width: headerView.frame.width, height: 40))
        name!.textAlignment = .Center
        name!.textColor = UIColor.whiteColor()
        headerView.addSubview(name!)
        
        self.desc = UILabel(frame: CGRect(x: 0, y: 130, width: headerView.frame.width, height: 30))
        name!.textAlignment = .Center
        name!.textColor = UIColor.whiteColor()
        headerView.addSubview(desc!)
        
        self.followers = RepoInfoView(frame: CGRectMake(0, headerView.frame.height, headerView.frame.width / 2, 40), name: "粉丝", value: 0)
        self.following = RepoInfoView(frame: CGRectMake(headerView.frame.width / 2, headerView.frame.height, headerView.frame.width / 2, 40), name: "关注", value: 0)
        self.addSubview(followers!)
        self.addSubview(following!)
        
        
        self.addSubview(headerView)
    }
    
    func setData(orgsData:JSON) {
        self.avatar?.sd_setImageWithURL(NSURL(string: orgsData["avatar_url"].string!))
        self.name?.text = orgsData["login"].string!
        self.desc?.text = orgsData["description"].string!
        self.followers?.setValue(orgsData["followers"].int!)
        self.following?.setValue(orgsData["following"].int!)
    }
}
