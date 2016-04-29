//
//  MyViewController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-27.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyViewController: UIViewController {
    //login view
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var githubUsername: UITextField!
    @IBOutlet weak var githubPassword: UITextField!
    @IBAction func GithubLogin(sender: AnyObject) {
        println("账号：\(githubUsername.text), 密码：\(githubPassword.text)")
        //self.performSegueWithIdentifier("GithubLogin", sender: self)
        
        if(githubUsername.text != "" && githubPassword.text != ""){
            //Github.login(githubUsername.text, password: githubPassword.text)
            Github.login(githubUsername.text, password: githubPassword.text, completionHandler: { (token, statusCode, errorMsg) -> () in
                if token != nil{
                    Github.setToken(token!)
                    println("显示档案页面")
                    self.showProfileView()
                }else{
                    //提示出错
                }
            })
        } else {
            println("账号或密码不得为空")
        }
        
    }
    
    //profile view
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    
    @IBAction func ShowMyRepositories(sender: UIButton) {
        println("我的项目")
        self.performSegueWithIdentifier("showRepositories", sender: sender)
    }
    @IBAction func ShowMyStars(sender: UIButton) {
        println("我的收藏")
        self.performSegueWithIdentifier("showRepositories", sender: sender)
    }
    @IBAction func GithubLogout(sender: AnyObject) {
        println("登出")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var token:String?
        var ud = NSUserDefaults.standardUserDefaults()
        if let token:String = Github.getToken(){
            showProfileView()
        }else{
            showLoginView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLoginView(){
        self.loginView.hidden = false
        self.profileView.hidden = true
    }
    
    func showProfileView(){
        self.loginView.hidden = true
        self.profileView.hidden = false
        loadProfileData()
    }
    
    func loadProfileData() {
        Github.getUserInfo { (userinfo) -> Void in
            println(userinfo)
            if let u: AnyObject = userinfo{
                OperationQueueHelper.operateInMainQueue({ () -> Void in
                    let json = JSON(u)
                    if let avatarData:NSData? = NSData(contentsOfURL: NSURL(string: json["avatar_url"].string!)!){
                        self.userAvatar.image = UIImage(data: avatarData!)
                    }
                    
                    self.userName.text = json["name"].string
                    self.userEmail.text = json["email"].string
                    self.userLocation.text = json["location"].string
                    self.userCompany.text = json["company"].string
                })
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRepositories" {
            var repo = segue.destinationViewController as RepositoryTableViewController
            //repo.repositoryData = "wqeqwe" as AnyObject
            
            if sender is UIButton{
                let button = sender as UIButton
                
                if button.titleLabel?.text == "我的项目" {
                    repo.navigationItem.title = "我的项目"
                    repo.repositoryData = "我的项目" as AnyObject
                } else if button.titleLabel?.text == "我的收藏"{
                    repo.navigationItem.title = "我的收藏"
                    repo.repositoryData = "我的收藏" as AnyObject
                }
            }
        }
        
    }
    
}
