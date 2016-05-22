//
//  UserInfo.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/16.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserBaseInfo{
    var type:String = ""
    var name:String = ""
    var id:Int = 0
    var avatarUrl:String = ""
    
    var data:AnyObject?
    
    init(){
        
    }
    init(data:AnyObject){
        parse(data)
    }
    
    func parse(data:AnyObject){
        let json = JSON(data)
        self.type = json["type"].string != nil ? json["type"].string! : ""
        self.id = json["id"].int!
        self.name = json["login"].string!
        self.avatarUrl = json["avatar_url"].string!
        
        self.data = data
    }
}