//
//  HTMLFetchController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/8/12.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class HTMLFetchController: UIViewController {

    var htmlUrl:UITextField?
    var htmlCodeView:UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func initView(){
        self.view.backgroundColor = UIColor.whiteColor()
        let frame = self.view.frame
        
        self.htmlUrl = UITextField(frame: CGRectMake(0,70,frame.width - 70, 20))
        self.htmlUrl?.placeholder = "在此输入网址"
        self.htmlUrl?.autocapitalizationType = .None
        self.htmlUrl?.autocorrectionType = .No
        self.htmlUrl?.borderStyle = .RoundedRect
        self.view.addSubview(self.htmlUrl!)
        
        let fetchBtn = UIButton(type: .System)
        fetchBtn.frame = CGRectMake(frame.width - 60,70,60,20)
        fetchBtn.setTitle("查询", forState: UIControlState.Normal)
        fetchBtn.addTarget(self, action: #selector(self.fetch), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(fetchBtn)
        
        self.htmlCodeView = UITextView(frame: CGRectMake(0,90,frame.width,frame.height - 90 - 44))
        self.htmlCodeView?.editable = false
        self.htmlCodeView?.selectable = false
        self.view.addSubview(self.htmlCodeView!)
    }
    
    func fetch(){
        let url:String = htmlUrl!.text!
        print("fetch \(url)")
        
        //收起键盘
        self.htmlUrl?.resignFirstResponder()
        
        ProgressHUD.show()
        HttpRequestHelper.sendRequest(url) { (data:NSData?, resp:NSURLResponse?, err:NSError?) in
            OperationQueueHelper.operateInMainQueue({ 
                ProgressHUD.dismiss()
                if(err != nil){
                    print(err)
                    self.htmlCodeView?.text = err?.description
                    return
                }
                
                if (data != nil){
                    if let res = NSString(data: data!, encoding: NSUTF8StringEncoding){
                        self.htmlCodeView?.text = String(res)
                    }
                }
            })
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
