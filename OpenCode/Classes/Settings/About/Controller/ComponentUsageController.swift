//
//  ComponentUsageController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/18.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class ComponentUsageController: UIViewController {

    lazy var textView:UITextView = UITextView(frame: self.view.bounds, textContainer: nil)
    var text:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.font = UIFont.systemFontOfSize(16)
        textView.textColor = UIColor.blackColor()
        textView.text = text
        self.view.addSubview(textView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
