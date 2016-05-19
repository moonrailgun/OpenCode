//
//  UserInfoHeaderView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/19.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class UserInfoHeaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var headerView:UIView?
    var avatar:UIImageView?
    var name:UILabel?
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 200))
        
        initView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initView(){
        self.headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 150))
        headerView!.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        
        self.avatar = UIImageView(frame: CGRect(x: headerView!.frame.width/2-50, y: 10, width: 100, height: 100))
        headerView?.addSubview(avatar!)
        
        self.name = UILabel(frame: CGRect(x: 0, y: 110, width: headerView!.frame.width, height: 40))
        name?.textAlignment = .Center
        name?.textColor = UIColor.whiteColor()
        headerView?.addSubview(name!)
        
        self.addSubview(headerView!)
    }
    
    func setData(avatar:UIImage, name:String) {
        self.avatar?.image = avatar
        self.name?.text = name
    }

}
