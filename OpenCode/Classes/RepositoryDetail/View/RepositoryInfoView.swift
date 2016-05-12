//
//  RepositoryInfoBlock.swift
//  OpenCode
//
//  Created by 陈亮 on 16-5-8.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

class RepositoryInfoView: UIView {
    var infoNameLabel:UILabel!
    var infoValueLabel:UILabel!
    
    init(frame: CGRect, name:String,value:Int) {
        super.init(frame: frame)
        
        infoNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: 20))
        infoNameLabel.text = name
        infoNameLabel.font = UIFont(descriptor: UIFontDescriptor(), size: 20)
        infoValueLabel = UILabel(frame: CGRect(x: 0, y: 20, width: frame.width, height: 20))
        infoValueLabel.text = value.description
        
        self.addSubview(infoNameLabel)
        self.addSubview(infoValueLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setName(name:String){
        self.infoNameLabel.text = name
    }
    
    func setValue(value:Int){
        self.infoValueLabel.text = String(value)
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
