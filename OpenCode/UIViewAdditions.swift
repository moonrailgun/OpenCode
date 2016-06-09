//
//  UIViewAdditions.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/3.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
/*
extension UIView{
    func getCurrentViewController() -> UIViewController?{
        for(var next = self.superview; (next != nil); next = next?.superview){
            var responder:UIResponder? = next?.nextResponder()
            while(responder != nil){
                if(responder!.isKindOfClass(UIViewController.self)){
                    return nextResponder as? UIViewController
                }
                responder = responder!.nextResponder()!
            }
            
        }
        return nil
    }
}*/

extension UIView{
    func removeAllSubview(){
        for view:UIView in self.subviews{
            view.removeFromSuperview()
        }
    }
}