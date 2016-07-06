//
//  PingController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/7/5.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class PingController: UIViewController {

    lazy var pingHostAddress:UITextField = UITextField(frame: CGRectMake(20,20 + 64,self.view.frame.width - 40,40))
    lazy var pingStartButton:UIButton = UIButton(type: UIButtonType.System)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Ping工具"
        
        pingHostAddress.borderStyle = .RoundedRect
        pingHostAddress.placeholder="请输入地址"
        pingHostAddress.textAlignment = .Center
        pingHostAddress.contentVerticalAlignment = .Center
        pingHostAddress.contentHorizontalAlignment = .Center
        pingHostAddress.clearButtonMode = .WhileEditing
        self.view.addSubview(pingHostAddress)
        pingStartButton.frame = CGRectMake(20,60 + 64,self.view.frame.width - 40, 40)
        pingStartButton.setTitle("开始ping", forState: .Normal)
        pingStartButton.addTarget(self, action: #selector(self.startPing), forControlEvents: .TouchUpInside)
        self.view.addSubview(pingStartButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startPing(){
        if let address = pingHostAddress.text{
            let temp = NSString(string: address)
            let tempComponents = temp.componentsSeparatedByString(".")
            if (address != "" && (temp.substringToIndex(3) == "http" || tempComponents.count >= 3)){
                print(address)
                let controller = PingDetailController()
                controller.hostAddress = address
                self.navigationController?.pushViewController(controller, animated: true)
            }else{
                let controller = UIAlertController(title: nil, message: "输入地址不合法", preferredStyle: .Alert)
                controller.addAction(UIAlertAction(title: "确定", style: .Default, handler: nil))
                self.presentViewController(controller, animated: true, completion: nil)
            }
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
