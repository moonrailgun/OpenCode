//
//  MyLoginView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/1.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class MyLoginView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var avatarImageView:UIImageView?
    var usernameTextField:UITextField?
    var passwordTextField:UITextField?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        let bounds = self.bounds
        
        let imageSize = CGSize(width: 100, height: 100)
        avatarImageView = UIImageView(frame: CGRect(x: bounds.width / 2 - imageSize.width / 2, y: 70, width: imageSize.width, height: imageSize.height))
        avatarImageView?.image = UIImage(named: "github-logo")
        self.addSubview(avatarImageView!)
        
        let textFieldSize = CGSize(width: bounds.width * 0.8, height: 32)
        usernameTextField = UITextField(frame: CGRect(x: bounds.width / 2 - textFieldSize.width / 2, y: 200, width: textFieldSize.width, height: textFieldSize.height))
        usernameTextField?.borderStyle = .RoundedRect
        usernameTextField?.placeholder="请输入用户名"
        usernameTextField?.textAlignment = .Center
        usernameTextField?.contentVerticalAlignment = .Center
        usernameTextField?.clearButtonMode = .WhileEditing
        self.addSubview(usernameTextField!)
        
        passwordTextField = UITextField(frame: CGRect(x: bounds.width / 2 - textFieldSize.width / 2, y: 240, width: textFieldSize.width, height: textFieldSize.height))
        passwordTextField?.borderStyle = .RoundedRect
        passwordTextField?.secureTextEntry = true
        passwordTextField?.placeholder="请输入密码"
        passwordTextField?.textAlignment = .Center
        passwordTextField?.contentVerticalAlignment = .Center
        usernameTextField?.clearButtonMode = .WhileEditing
        self.addSubview(passwordTextField!)
    }
}
