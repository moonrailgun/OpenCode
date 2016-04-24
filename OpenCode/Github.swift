//
//  File.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-22.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

struct GithubEvent{
    let type: String
    let time: String
    let actor: AnyObject!
    let repo: AnyObject!
}

class Github {
    let API_URL = "https://api.github.com/"
    
    class func getEvents(completionHandler:([GithubEvent]!,NSError?) -> ()) {
        HttpRequest<NSData>.Request("https://api.github.com/events", completionHandler: {object,error in
            let json: AnyObject! = NSJSONSerialization.JSONObjectWithData(object!, options: NSJSONReadingOptions.MutableContainers, error: nil)
            let jsonArr = json as NSArray
            var events = [GithubEvent]()
            
            for var index = 0; index < jsonArr.count; index++ {
                let tmp: AnyObject = jsonArr[index]
                let event = GithubEvent(type: tmp["type"] as String, time: tmp["created_at"] as String, actor: tmp["actor"]!, repo: tmp["repo"]!)
                
                //println(event.actor)
                //println(index)
                
                events.append(event)
            }
            
            completionHandler(events,error)
        })
    }
}