//
//  RepositortDescBlock.swift
//  OpenCode
//
//  Created by 陈亮 on 16-5-8.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

class RepoDescView: UIView {
    var descLabel:UILabel!
    var iconView:UIImageView!
    
    init(frame: CGRect, icon:UIImage, desc: String) {
        super.init(frame: frame)
        
        let iconSize = CGSize(width: 24, height: 24)
        let iconSpace = (frame.height - iconSize.height) / 2
        iconView = UIImageView(frame: CGRect(origin: CGPoint(x: iconSpace, y: iconSpace), size: iconSize))
        iconView.image = icon
        self.addSubview(iconView)
        
        descLabel = UILabel(frame: CGRect(x: iconSpace * 2 + iconSize.width, y: 0, width: frame.width - (iconSpace * 2 + iconSize.width), height: frame.height))
        descLabel.text = desc
        descLabel.font = UIFont.systemFontOfSize(14)
        self.addSubview(descLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
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
