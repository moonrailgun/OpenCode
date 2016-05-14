//
//  File.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/12.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class GlobalDefine{
    static let defineBackgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
    
    static func getScreenWidth()->CGFloat{
        return UIScreen.mainScreen().bounds.size.width
    }
    static func getScreenHeight()->CGFloat{
        return UIScreen.mainScreen().bounds.size.height
    }
}