//
//  RepositoryInfoBlock.swift
//  OpenCode
//
//  Created by 陈亮 on 16-5-8.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

class RepoInfoView: UIView {
    var infoNameLabel:UILabel!
    var infoValueLabel:UILabel!
    
    init(frame: CGRect, name:String,value:Int) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        infoValueLabel = UILabel(frame: CGRect(x: 0, y: 2, width: frame.width, height: 20))
        infoValueLabel.text = value.description
        infoValueLabel.font = UIFont.systemFontOfSize(18)
        infoValueLabel.textAlignment = .Center
        infoNameLabel = UILabel(frame: CGRect(x: 0, y: 20, width: frame.width, height: 18))
        infoNameLabel.text = name
        infoNameLabel.font = UIFont.systemFontOfSize(14)
        infoNameLabel.textAlignment = .Center
        
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
