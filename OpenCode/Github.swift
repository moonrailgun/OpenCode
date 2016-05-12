//
//  File.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-22.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

enum GithubEventType{
    case
    CreateEvent,
    PushEvent,
    WatchEvent,
    ForkEvent,
    PullRequestEvent,
    IssuesCommentEvent,
    GollumEvent,
    DeleteEvent,
    Unknow
}

struct GithubRepository {
    let id: Int
    let name: String
    let fullName: String
    let description: String
    let isPrivate: Bool
    let html_url: String
    let isFork: Bool
    let created_at:String
    let pushed_at:String
    let size: Int
    let forks: Int
}

class Github {
    let API_URL = "https://api.github.com/"
    
    class func getEvents(completionHandler:(AnyObject?) -> Void) {
        /*HttpDataRequest<NSData>.request("https://api.github.com/events", completionHandler: {object,error in
            let json: AnyObject! = NSJSONSerialization.JSONObjectWithData(object!, options: NSJSONReadingOptions.MutableContainers, error: nil)
            let jsonArr = json as NSArray
            var events = [GithubEvent]()
            
            for var index = 0; index < jsonArr.count; index++ {
                let tmp: AnyObject = jsonArr[index]
                let event = GithubEvent(type: tmp["type"] as String, time: tmp["created_at"] as String, actor: tmp["actor"]!, repo: tmp["repo"]!)
                
                events.append(event)
            }
            
            completionHandler(events,error)
        })*/
        
        requestPublicData("https://api.github.com/events", completionHandler: completionHandler)
    }
    
    //登录到github并返回一个token
    class func login(username:String, password: String, completionHandler:(token:String?,statusCode: Int!,errorMsg:String?) -> ()) -> Void{
        let str = username + ":" + password
        let authorization = "Basic " + Base64.encrypt(str)!
        var header = NSDictionary()
        header = ["Authorization": authorization, "Content-Type": "application/json"]
        let data = "{\"note\":\"OpenCodeApp\"}"
        
        HttpRequest.sendAsyncPostRequest(NSURL(string: "https://api.github.com/authorizations")!, header: header, data: data) { (resp:NSURLResponse?, data:NSData?, error:NSError?) in
            if let httpResp = resp as? NSHTTPURLResponse{
                switch httpResp.statusCode{
                case 422:
                    print("已经登录过了")
                    completionHandler(token: nil, statusCode: 422, errorMsg: nil)
                    break
                case 201:
                    print("登录成功")
                    let json = JSON(data: data!)
                    let authorizationId = json["id"]
                    let authorizationToken = json["token"]
                    print("id: \(authorizationId) token : \(authorizationToken)")
                    completionHandler(token: authorizationToken.string, statusCode: 201, errorMsg: nil)
                    break
                default:
                    print("登录失败:\(httpResp.statusCode)")
                    completionHandler(token: nil, statusCode: httpResp.statusCode, errorMsg: nil)
                    break
                }
            } else {
                let message = JSON(data: data!)["message"]
                print("登录失败: \(message)")
                completionHandler(token: nil, statusCode: 0, errorMsg: message.string)
            }

        }
    }
    //获取用户信息
    class func getUserInfo(completionHandler:(AnyObject?) -> Void) {
        requestPrivateData("https://api.github.com/user", completionHandler: completionHandler)
    }
    //获取当前用户的项目列表数据
    class func getCurrentUserRepositories(completionHandler:(AnyObject?) -> Void){
        requestPrivateData("https://api.github.com/user/repos", completionHandler: completionHandler)
    }
    class func getCurrentUserStarred(completionHandler:(AnyObject?) -> Void){
        requestPrivateData("https://api.github.com/user/starred", completionHandler: completionHandler)
    }
    //获取当前用户的粉丝
    class func getCurrentUserFollowers(completionHandler:(AnyObject?) -> Void) {
        requestPrivateData("https://api.github.com/user/followers", completionHandler: completionHandler)
    }
    //获取当前用户的关注
    class func getCurrentUserFollowing(completionHandler:(AnyObject?) -> Void){
        requestPrivateData("https://api.github.com/user/following", completionHandler: completionHandler)
    }
    //获取用户收藏
    class func getUserStarred(username:String, completionHandler:(AnyObject?) -> Void) {
        requestPublicData("https://api.github.com/users/\(username)/starred", completionHandler: completionHandler)
    }
    //获取github代码搜索结果
    class func getGithubCodeSearch(query:String, page:Int?, perPage:Int?, sort:Int?, order:Int?, completionHandler:(AnyObject?) -> Void){
        var url:String = "https://api.github.com/search/code?q=\(query)"
        if page != nil{
            url += "&page=\(page)"
        }
        if perPage != nil{
            url += "&per_page=\(perPage)"
        }
        if sort != nil{
            url += "&sort=\(sort)"
        }
        if order != nil{
            url += "&order=\(order)"
        }
        requestPublicData(url, completionHandler: completionHandler)
    }
    //自定义地址的github api获取
    class func customRequest(url:String, isPublic:Bool, completionHandler:(AnyObject?) -> Void){
        if(isPublic){
            requestPublicData(url, completionHandler: completionHandler)
        }else{
            requestPrivateData(url, completionHandler: completionHandler)
        }
    }
    //获取公开数据通用方法
    class private func requestPublicData(url: String, completionHandler:(AnyObject?) -> Void){
        HttpRequest.sendAsyncRequest(NSURL(string: url)!, completionHandler: { (resp:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
            if let d = data{
                completionHandler(self.convertDataToJSONObj(d))
            }else{
                print("\(url): 无法获取数据: resp:\(resp) data:\(data) error:\(error)")
                completionHandler(nil)
            }
        })
    }
    //获取私人数据通用方法
    class private func requestPrivateData(url:String, completionHandler:(AnyObject?) -> Void){
        if let token:String = getToken(){
            HttpRequest.sendAsyncRequest(NSURL(string: url + "?access_token=\(token)")!, completionHandler: { (resp:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
                if let d = data{
                    completionHandler(self.convertDataToJSONObj(d))
                }else{
                    print("\(url): 无法获取数据: resp:\(resp) data:\(data) error:\(error)")
                    completionHandler(nil)
                }
            })
        } else{
            print("\(url): token 不存在，无法获取数据")
            completionHandler(nil)
        }
    }
    
    //将二进制对象转化为JSON的通用对象
    class func convertDataToJSONObj(data:NSData?) ->AnyObject? {
        if let d = data{
            let json = JSON(data: d, options: NSJSONReadingOptions.AllowFragments, error: nil)
            return json.object
        }else{
            return nil
        }
    }
    
    class func parseGithubTime(string:String) -> String{
        let formatter = NSDateFormatter()
        //formatter.timeZone = NSTimeZone(name: "Asia/Shanghai")
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 8 * 60 * 60)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = NSDate.parseWithFormatter(string, formatter: formatter)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeStr = dateFormatter.stringFromDate(date!)
        
        return timeStr
    }
    
    class func setToken(token:String){
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(token, forKey: "GithubToken")
    }
    class func getToken() -> String?{
        let ud = NSUserDefaults.standardUserDefaults()
        return ud.objectForKey("GithubToken") as? String
    }
    class func parseEventType(eventType:String) -> GithubEventType{
        var type:GithubEventType
        switch eventType{
        case "CreateEvent":
            type = .CreateEvent
        case "PushEvent":
            type = .PushEvent
        case "WatchEvent":
            type = .WatchEvent
        case "ForkEvent":
            type = .ForkEvent
        case "PullRequestEvent":
            type = .PullRequestEvent
        case "IssuesCommentEvent":
            type = .IssuesCommentEvent
        case "GollumEvent":
            type = .GollumEvent
        case "DeleteEvent":
            type = .DeleteEvent
        default:
            type = .Unknow
        }
        
        return type
    }
}