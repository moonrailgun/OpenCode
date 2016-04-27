//
//  MyViewController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-27.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var githubUsername: UITextField!
    @IBOutlet weak var githubPassword: UITextField!
    @IBAction func GithubLogin(sender: AnyObject) {
        println("账号：\(githubUsername.text), 密码：\(githubPassword.text)")
        //self.performSegueWithIdentifier("GithubLogin", sender: self)
        
        showProfileView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var token:String?
        if((token) != nil){
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
