//
//  BubbleView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/8/30.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class BubbleView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    let label:UILabel = UILabel()

    init(text:String) {
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.clearColor()
        print(self.bounds)
        
        label.text = text;
        label.bounds = CGRectMake(0,0,180,2000);
        label.sizeToFit()
        self.addSubview(label)
        self.frame = label.frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
