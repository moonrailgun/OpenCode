//
//  NewsScrollView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/29.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class NewsScrollView: UIScrollView {
    
    let windowSize:CGFloat = 4
    
    init(frame: CGRect, controller:UIViewController) {
        super.init(frame: frame)
        
        initView(controller)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initView(nil)
    }
    
    func initView(controller:UIViewController?){
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentSize = CGSizeMake(windowSize * screenWidth, 0);
        self.pagingEnabled = true
        self.backgroundColor = UIColor.clearColor()
        self.bounces = false
        
        /*
        var viewClassArr: [AnyObject] = [NewsEventListView.self, NewsEventListView.self, NewsEventListView.self, NewsEventListView.self]
        for i in 0 ..< windowSize {
            var view: UIView = (viewClassArr[i] as! UIView)(frame: CGRectMake(i * screenWidth, 0, screenWidth, self.height))
            self.addSubview(view)
        }*/
        
        let view1 = NewsEventListView(frame: CGRect(x: 0 * screenWidth, y: 0, width: screenWidth, height: self.bounds.height), controller: controller)
        self.addSubview(view1)
        let view2 = HotRepoView(frame: CGRect(x: 1 * screenWidth, y: 0, width: screenWidth, height: self.bounds.height),controller: controller)
        self.addSubview(view2)
        let view3 = TrendingView(frame: CGRect(x: 2 * screenWidth, y: 0, width: screenWidth, height: self.bounds.height))
        self.addSubview(view3)
        let view4 = TrendingView(frame: CGRect(x: 3 * screenWidth, y: 0, width: screenWidth, height: self.bounds.height))
        self.addSubview(view4)
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
