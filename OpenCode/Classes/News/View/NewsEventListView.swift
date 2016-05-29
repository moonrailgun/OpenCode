//
//  NewsEventListView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/29.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class NewsEventListView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 40))
        label.text = "画面"
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
