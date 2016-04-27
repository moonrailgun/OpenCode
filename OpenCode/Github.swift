//
//  File.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-22.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

struct GithubEvent{
    let type: String
    let time: String
    let actor: AnyObject!
    let repo: AnyObject!
}

class Github {
    let API_URL = "https://api.github.com/"
    
    class func getEvents(completionHandler:([GithubEvent]!,NSError?) -> ()) {
        HttpDataRequest<NSData>.request("https://api.github.com/events", completionHandler: {object,error in
            let json: AnyObject! = NSJSONSerialization.JSONObjectWithData(object!, options: NSJSONReadingOptions.MutableContainers, error: nil)
            let jsonArr = json as NSArray
            var events = [GithubEvent]()
            
            for var index = 0; index < jsonArr.count; index++ {
                let tmp: AnyObject = jsonArr[index]
                let event = GithubEvent(type: tmp["type"] as String, time: tmp["created_at"] as String, actor: tmp["actor"]!, repo: tmp["repo"]!)
                
                events.append(event)
            }
            
            completionHandler(events,error)
        })
    }
    
    //登录到github并返回一个token
    class func login(username:String, password: String) -> String{
        let str = username + ":" + password
        let authorization = "Basic " + Base64.encrypt(str)!
        var header = NSDictionary()
        header = ["Authorization": authorization, "Content-Type": "application/json"]
        let data = "{\"note\":\"OpenCodeApp\"}"
        
        HttpRequest.sendAsyncPostRequest(NSURL(string: "https://api.github.com/authorizations")!, header: header, data: data) { (resp:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            if let httpResp = resp as? NSHTTPURLResponse{
                switch httpResp.statusCode{
                case 422:
                    println("已经登录过了")
                    break
                case 201:
                    println("登录成功")
                    let json = JSON(data: data)
                    let authorizationId = json["id"]
                    let authorizationToken = json["token"]
                    println("token : \(authorizationToken)")
                    break
                default:
                    println("登录失败:\(httpResp.statusCode)")
                    break
                }
            }else{
                println("出现错误\(resp)")
            }
        }
        
        return str
    }
    
    class func parseGithubTime(string:String) -> String{
        var formatter = NSDateFormatter()
        //formatter.timeZone = NSTimeZone(name: "Asia/Shanghai")
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 8 * 60 * 60)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        var date = NSDate.parseWithFormatter(string, formatter: formatter)
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeStr = dateFormatter.stringFromDate(date!)
        
        return timeStr
    }
}