//
//  MyLoginView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/1.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class MyLoginView: UIView, UITextFieldDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var controller:UIViewController?
    
    var avatarImageView:UIImageView?
    var usernameTextField:UITextField?
    var passwordTextField:UITextField?
    var loginBtn:UIButton?
    var registerBtn:UIButton?

    init(frame: CGRect, controller:UIViewController) {
        super.init(frame: frame)
        
        self.controller = controller
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        let bounds = self.bounds
        self.backgroundColor = UIColor.whiteColor()
        
        let imageSize = CGSize(width: 100, height: 100)
        avatarImageView = UIImageView(frame: CGRect(x: bounds.width / 2 - imageSize.width / 2, y: 70, width: imageSize.width, height: imageSize.height))
        avatarImageView?.image = UIImage(named: "github-logo")
        self.addSubview(avatarImageView!)
        
        let textFieldSize = CGSize(width: bounds.width * 0.8, height: 32)
        usernameTextField = UITextField(frame: CGRect(x: bounds.width / 2 - textFieldSize.width / 2, y: 200, width: textFieldSize.width, height: textFieldSize.height))
        usernameTextField?.autocorrectionType = .No
        usernameTextField?.autocapitalizationType = .None
        usernameTextField?.borderStyle = .RoundedRect
        usernameTextField?.placeholder="请输入用户名"
        usernameTextField?.textAlignment = .Center
        usernameTextField?.contentVerticalAlignment = .Center
        usernameTextField?.contentHorizontalAlignment = .Center
        usernameTextField?.clearButtonMode = .WhileEditing
        usernameTextField?.delegate = self
        self.addSubview(usernameTextField!)
        
        passwordTextField = UITextField(frame: CGRect(x: bounds.width / 2 - textFieldSize.width / 2, y: 240, width: textFieldSize.width, height: textFieldSize.height))
        passwordTextField?.autocorrectionType = .No
        passwordTextField?.autocapitalizationType = .None
        passwordTextField?.borderStyle = .RoundedRect
        passwordTextField?.secureTextEntry = true
        passwordTextField?.placeholder="请输入密码"
        passwordTextField?.textAlignment = .Center
        passwordTextField?.contentVerticalAlignment = .Center
        passwordTextField?.contentHorizontalAlignment = .Center
        passwordTextField?.clearButtonMode = .WhileEditing
        passwordTextField?.delegate = self
        self.addSubview(passwordTextField!)
        
        let buttonSize = CGSize(width: bounds.width * 0.8, height: 40)
        loginBtn = UIButton(frame: CGRectMake(bounds.width / 2 - buttonSize.width / 2, 300, buttonSize.width, buttonSize.height))
        loginBtn?.setTitle("登陆", forState: .Normal)
        loginBtn?.backgroundColor = UIColor.peterRiverFlatColor()
        loginBtn?.addTarget(self, action: #selector(MyLoginView.login), forControlEvents: .TouchUpInside)
        self.addSubview(loginBtn!)
        
        let attributedStr = NSMutableAttributedString(string: "还没有帐号么？点此注册")
        attributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.peterRiverFlatColor(), range: NSMakeRange(7, 4))
        attributedStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: NSMakeRange(0, 11))
        registerBtn = UIButton(frame: CGRectMake(bounds.width / 2 - buttonSize.width / 2, bounds.height - 100, buttonSize.width, buttonSize.height))
        registerBtn?.setAttributedTitle(attributedStr, forState: .Normal)
        registerBtn?.addTarget(self, action: #selector(MyLoginView.register), forControlEvents: .TouchUpInside)
        self.addSubview(registerBtn!)
    }
    
    func login(){
        if let _ = Github.getToken(){
            print("已经登陆过")
            return
        }
        
        let username = usernameTextField!.text!
        let password = passwordTextField!.text!
        print("登陆 － 账号：\(username)")
        
        if(username != "" && password != ""){
            //Github.login(githubUsername.text, password: githubPassword.text)
            ProgressHUD.show()
            Github.login(username, password: password, completionHandler: { (token, statusCode, errorMsg) -> () in
                OperationQueueHelper.operateInMainQueue({
                    ProgressHUD.dismiss()
                    if(statusCode == 422){
                        //已经登陆
                        let alert = UIAlertController(title: "已经登陆", message: "是否重新登陆", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "确定", style: .Default, handler: { (action:UIAlertAction) in
                            //登出
                            Github.logout(username, password: password, completionHandler: { () -> Void? in
                                self.login()
                            })
                        }))
                        alert.addAction(UIAlertAction(title: "取消", style: .Default, handler: nil))
                        self.controller?.presentViewController(alert, animated: true, completion: nil)
                    }else if(statusCode == 201){
                        if token != nil{
                            Github.setToken(token!)
                            print("显示档案页面")
                            
                            //关闭该页面
                            (self.controller as! MyController).initProfileView()
                            self.removeFromSuperview()
                        }else{
                            //提示出错
                            print("出错 - token:\(token),code:\(statusCode),errorMsg:\(errorMsg)")
                        }
                    }else{
                        let alert = UIAlertController(title: "登陆失败", message: "\(errorMsg != nil ? errorMsg! : "" )", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "确定", style: .Default, handler: nil))
                        self.controller?.presentViewController(alert, animated: true, completion: nil)
                    }
                })
            })
        } else {
            print("账号或密码不得为空")
        }
    }
    
    func register(){
        print("注册")
        
        UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/join")!)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
