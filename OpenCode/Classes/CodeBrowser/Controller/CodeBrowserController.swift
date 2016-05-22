//
//  CodeBrowserController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/22.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import JavaScriptCore

class CodeBrowserController: UIViewController, UIWebViewDelegate {
    
    var webView:UIWebView?
    var code:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initWebView(){
        self.webView = UIWebView(frame: self.view.bounds)
        self.webView?.delegate = self
        self.view.addSubview(webView!)
        
        let url = NSBundle.mainBundle().URLForResource("CodeBrowser", withExtension: "html")
        self.webView?.loadRequest(NSURLRequest(URL: url!))
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        var script:String
        if let c = code{
            script =  "loadCode(\'" + c + "\')"	
        }else{
            script = "loadCode('发生错误：没有接收到代码')"
        }
        script = script.stringByReplacingOccurrencesOfString("\n", withString: "<br/>", options: NSStringCompareOptions.LiteralSearch, range: nil)
        print(script)
        webView.stringByEvaluatingJavaScriptFromString(script)
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("网页加载失败:\(error)")
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
