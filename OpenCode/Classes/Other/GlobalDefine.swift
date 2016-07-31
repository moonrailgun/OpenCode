//
//  File.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/12.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class GlobalDefine{
    static let defaultBackgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
    static let iconGrey = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)//#bdc3c7
    
    static func getScreenWidth()->CGFloat{
        return UIScreen.mainScreen().bounds.size.width
    }
    static func getScreenHeight()->CGFloat{
        return UIScreen.mainScreen().bounds.size.height
    }
    
    static func addEventListener(observer:AnyObject, selector: Selector, name:String?,object:AnyObject?){
        NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: name, object: object)
    }
    static func removeEventListener(observer:AnyObject, name:String?,object:AnyObject?){
        NSNotificationCenter.defaultCenter().removeObserver(observer, name: name, object: object)
    }
}