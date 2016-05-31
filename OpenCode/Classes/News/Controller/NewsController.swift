//
//  NewsController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/29.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class NewsController: UIViewController, UIScrollViewDelegate, NewsTopDelegate {
    lazy var topView:NewsTopView = NewsTopView(frame: CGRect(x: 0, y: 64, width:Int(self.view.frame.size.width), height: 36))
    lazy var mainScrollView:NewsScrollView = NewsScrollView(frame: CGRect(x: 0, y: 100, width:Int(self.view.frame.size.width), height: Int(self.view.frame.size.height) - 100))

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
        self.topView.delegate = self
        self.view.addSubview(topView)
        
        self.mainScrollView.delegate = self
        self.view.addSubview(mainScrollView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let column = CGFloat(self.topView.names.count)
        UIView.animateWithDuration(0.25) { 
            self.topView.underLine.transform = CGAffineTransformMakeTranslation(x / column, 0);
        }
    }
    
    func onTopViewBtnClick(tag: Int) {
        print(tag)
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        self.mainScrollView.contentOffset = CGPointMake(CGFloat(tag - 100) * screenWidth, 0);
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
