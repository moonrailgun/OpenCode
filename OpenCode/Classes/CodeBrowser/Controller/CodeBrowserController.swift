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
        //self.webView?.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 240)
        self.webView?.delegate = self
        self.view.addSubview(webView!)
        /*
        let url = NSBundle.mainBundle().URLForResource("CodeBrowser", withExtension: "html")
        self.webView?.loadRequest(NSURLRequest(URL: url!))*/
        
        loadHtml()
    }
    
    func loadHtml(){
        if var c = code{
            //处理转译
            c = c.stringByReplacingOccurrencesOfString("\n", withString: "<br/>", options: NSStringCompareOptions.LiteralSearch, range: nil)
            c = c.stringByReplacingOccurrencesOfString("'", withString: "\'", options: NSStringCompareOptions.LiteralSearch, range: nil)
            //c = c.stringByReplacingOccurrencesOfString("\'", withString: "\\'", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            var html:String = ""
            html += "<head>"
            html += "<script src=\"highlight.min.js\"></script>"
            html += "<link href=\"default.min.css\" rel=\"stylesheet\">"
            html += "</head>"
            html += "<body><div><pre><code>"
            html += c
            html += "</pre></code></div></body>"
            html += "<script>hljs.initHighlightingOnLoad();</script>"
            
            webView?.loadHTMLString(html, baseURL: NSBundle.mainBundle().resourceURL)
        }else{
            print("发生错误，没有获取到代码")
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("载入完毕")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("网页加载失败:\(error)")
    }
    
    func parseData(content:String, encoding:String){
        if(encoding == "base64"){
            self.code = Base64.decrypt(content)
        }else{
            print("未知的编码方式")
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
