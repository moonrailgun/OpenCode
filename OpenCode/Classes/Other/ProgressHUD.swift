//
//  ProgressHUD.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/9.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import Foundation
import SVProgressHUD

class ProgressHUD{
    class func show(){
        SVProgressHUD.setDefaultMaskType(.Clear)
        SVProgressHUD.show()
    }
    class func dismiss(){
        SVProgressHUD.dismiss()
    }
}