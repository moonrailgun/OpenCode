//
//  MarkdownReaderController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/14.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import TSMarkdownParser

class MarkdownReaderController: UIViewController {
    lazy var textView:UITextView = UITextView(frame: self.view.bounds, textContainer: nil)
    var string:NSAttributedString?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        if(string != nil){
            textView.attributedText = string!
        }
        self.view.addSubview(textView)
    }
    
    func setMarkdownStr(markdown:String){
        let string = TSMarkdownParser.standardParser().attributedStringFromMarkdown(markdown)
        self.string = string
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
