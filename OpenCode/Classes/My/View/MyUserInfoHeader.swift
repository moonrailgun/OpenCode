//
//  MyUserInfoHeader.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/2.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class MyUserInfoHeader: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var avatar:UIImageView?
    var username:UILabel?
    
    init(){
        super.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 180 + 44))
        
        let background = UIImageView(image: UIImage(named: "bg"))
        background.frame = self.bounds
        self.addSubview(background)
        
        let avatarSize = CGSize(width: 90, height: 90)
        avatar = UIImageView(frame: CGRectMake(self.bounds.width/2-avatarSize.width/2, 64 , avatarSize.width, avatarSize.height))
        avatar!.backgroundColor = UIColor.clearColor()
        self.addSubview(avatar!)
        
        let labelSize = CGSize(width: self.bounds.width, height: 28)
        username = UILabel(frame: CGRectMake(0, 160, labelSize.width, labelSize.height))
        username!.text = "@username"
        username!.textColor = UIColor.whiteColor()
        username!.textAlignment = .Center
        username!.font = UIFont.systemFontOfSize(18)
        self.addSubview(username!)
    }
    
    override init(frame: CGRect){
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(avatarImg:UIImage, username:String){
        self.avatar?.image = avatarImg
        self.username?.text = "@\(username)"
    }
}
