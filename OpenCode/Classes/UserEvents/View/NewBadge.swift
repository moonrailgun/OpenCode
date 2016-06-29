//
//  NewBadge.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/10.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class NewBadge: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        
        CGContextMoveToPoint(context, rect.minX, rect.minY)
        CGContextAddLineToPoint(context, rect.maxX, rect.minY)
        CGContextAddLineToPoint(context, rect.maxX, rect.maxY)
        CGContextClosePath(context)
        
        let color = UIColor.peterRiverFlatColor()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextDrawPath(context, .Fill)
    }

}
