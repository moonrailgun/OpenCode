//
//  OrgsDetailHeaderView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/27.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class OrgsDetailHeaderView: UIView {

    lazy var headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 150))
    var avatar:UIImageView?
    var name:UILabel?
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
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 200))
        
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
        
        self.followers = RepoInfoView(frame: CGRectMake(0, 150, headerView.frame.width / 2, 40), name: "粉丝", value: 0)
        self.following = RepoInfoView(frame: CGRectMake(headerView.frame.width / 2, 150, headerView.frame.width / 2, 40), name: "关注", value: 0)
        self.addSubview(followers!)
        self.addSubview(following!)
        
        
        self.addSubview(headerView)
    }
    
    func setData(avatar:UIImage, name:String,followersNum:Int, followingNum:Int) {
        self.avatar?.image = avatar
        self.name?.text = name
        self.followers?.setValue(followersNum)
        self.following?.setValue(followingNum)
    }
}
