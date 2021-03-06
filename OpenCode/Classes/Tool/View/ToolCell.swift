//
//  ToolCell.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/25.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class ToolCell: UICollectionViewCell {
    static let size:CGSize = CGSize(width: 60, height: 70)
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        /*
        self.backgroundColor = UIColor.whiteColor()
        
        //image
        image = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height: 40))
        image?.image = UIImage(named: "code")
        image?.layer.cornerRadius = 20
        self.addSubview(image!)
        
        label = UILabel(frame: CGRect(x: 0, y: 45, width: ToolCell.size.width, height: 25))
        //label?.text = "text"
        label?.textAlignment = .Center
        label?.minimumScaleFactor = 0.5
        label?.font = UIFont.systemFontOfSize(12)
        self.addSubview(label!)*/
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setData(image:UIImage, text:String){
        self.image.image = image
        self.label.text = text
    }
}
