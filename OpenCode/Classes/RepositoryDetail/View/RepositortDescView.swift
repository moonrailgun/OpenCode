//
//  RepositortDescBlock.swift
//  OpenCode
//
//  Created by 陈亮 on 16-5-8.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

class RepositortDescView: UIView {
    var descLabel:UILabel!
    var iconView:UIImageView!
    
    init(frame: CGRect, icon:UIImage, desc: String) {
        super.init(frame: frame)
        
        let iconSize = CGSize(width: 24, height: 24)
        iconView = UIImageView(frame: CGRect(origin: CGPoint(x: 4, y: frame.height - 4), size: iconSize))
        iconView.image = icon
        self.addSubview(iconView)
        
        descLabel = UILabel(frame: CGRect(x: 4 + iconSize.width, y: 0, width: frame.width - (4 + iconSize.width), height: frame.height))
        descLabel.text = desc
        self.addSubview(descLabel!)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setDesc(desc:String){
        self.descLabel?.text = desc
    }
    
    func setIcon(icon:UIImage){
        self.iconView.image = icon
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
    }*/

}
