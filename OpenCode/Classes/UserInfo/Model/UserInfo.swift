//
//  UserInfo.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/18.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserInfo: UserBaseInfo {
    var followers:Int = 0
    var following:Int = 0
    var email:String? = ""
    var location:String? = ""
    var company:String? = ""
    var blog:String? = ""
    var plan:JSON = []
    
    var repos_url:String = ""
    var events_url:String = ""
    var received_events_url:String = ""
    var starred_url:String? = ""
    var gists_url:String = ""
    var followers_url:String = ""
    var following_url:String = ""
    
    var created_at:String = ""
    var updated_at:String = ""
    
    override func parse(data: AnyObject) {
        super.parse(data)
        
        let json = JSON(data)
        let name = json["name"]
        if name != nil {
            self.name = name.string!
        }else{
            print("name为登陆名：\(self.name)")
        }
        
        self.followers = json["followers"].int!
        self.following = json["following"].int!
        self.email = json["email"].string
        self.location = json["location"].string
        self.company = json["company"].string
        self.blog = json["blog"].string
        self.plan = json["plan"]
        
        self.repos_url = json["repos_url"].string!
        self.events_url = json["events_url"].string!
        self.received_events_url = json["received_events_url"].string!
        self.starred_url = json["starred_url"].string!
        self.gists_url = json["gists_url"].string!
        self.followers_url = json["followers_url"].string!
        self.following_url = json["following_url"].string!
        
        self.created_at = json["created_at"].string!
        self.updated_at = json["updated_at"].string!
    }
}