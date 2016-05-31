//
//  NewsTopView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/31.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class NewsTopView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate:NewsTopDelegate?
    var lastTouchBtnTag:Int = 100
    lazy var underLine = UIView(frame: CGRect(x: 10, y: 34, width: UIScreen.mainScreen().bounds.size.width / 4 - 20, height: 2))
    let names = ["新鲜事","热门项目","趋势","暂定"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        self.backgroundColor = UIColor.sunFlowerFlatColor()
        
        let column = names.count
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        
        for i in 0 ..< column {
            let btn = UIButton(type: .Custom)
            btn.setTitle(names[i], forState: .Normal)
            btn.frame = CGRect(x: screenWidth / CGFloat(column) * CGFloat(i), y: 2, width: screenWidth / CGFloat(column), height: 32)
            btn.setTitleColor(UIColor(white: 1, alpha: 1), forState: .Normal)
            
            btn.addTarget(self, action: #selector(moveUnderLine(_:)), forControlEvents: .TouchUpInside)
            
            btn.tag = 100 + i
            btn.titleLabel?.font = UIFont.systemFontOfSize(14)
            btn.titleLabel?.textAlignment = .Center
            self.addSubview(btn)
        }
        
        let button = self.viewWithTag(100) as! UIButton
        button.tag = 100
        button.selected = true
        lastTouchBtnTag = 100
        
        self.underLine.backgroundColor = UIColor.whiteColor()
        self.addSubview(underLine)
    }
    
    func moveUnderLine(button:UIButton){
        let tag = button.tag
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        
        self.changeBtnSelect(tag)
        delegate?.onTopViewBtnClick(tag)
        UIView.animateWithDuration(0.25) { 
            self.underLine.transform = CGAffineTransformMakeTranslation((CGFloat(tag) - 100) * screenWidth / CGFloat(self.names.count), 0)
        }
    }
    
    func changeBtnSelect(tag:Int){
        let lastBtn = self.viewWithTag(lastTouchBtnTag) as! UIButton
        lastBtn.selected = false
        
        let currentBtn = self.viewWithTag(tag) as! UIButton
        currentBtn.selected = true
        lastTouchBtnTag = tag
    }
}
