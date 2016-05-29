//
//  NewsController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/29.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class NewsController: UIViewController, UIScrollViewDelegate {
    var mainScrollView:UIScrollView?

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
        self.mainScrollView = NewsScrollView(frame: self.view.bounds)
        self.mainScrollView?.delegate = self
        self.view.addSubview(mainScrollView!)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //let x = scrollView.contentOffset.x
        
        //print(x)
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
