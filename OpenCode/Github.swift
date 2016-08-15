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
        requestPublicData("https://api.github.com/events", completionHandler: completionHandler)
    }
    
    //登录到github并返回一个token
    class func login(username:String, password: String, completionHandler:(token:String?,statusCode: Int!,errorMsg:String?) -> ()) -> Void{
        let str = username + ":" + password
        let authorization = "Basic " + Base64.encrypt(str)!
        let appid:String = UIDevice.currentDevice().identifierForVendor!.UUIDString
        var header = NSDictionary()
        header = ["Authorization": authorization, "Content-Type": "application/json"]
        let data = "{\"note\":\"OpenCodeApp[\(appid)]\"}"
        
        //构造私有请求
        HttpRequestHelper.sendRequest("https://api.github.com/authorizations", method: HttpRequestMethod.POST, header: header, body: data) { (data:NSData?, resp:NSURLResponse?, error:NSError?) in
            if let httpResp = resp as? NSHTTPURLResponse{
                switch httpResp.statusCode{
                case 422:
                    print("已经登录过了，appid:\(appid)")
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
    //登出github
    class func logout(username:String, password: String, completionHandler:()->Void?){
        self.clearToken()
        
        //清除github服务器上数据
        print("登出需要验证结果")
        let str = username + ":" + password
        let authorization = "Basic " + Base64.encrypt(str)!
        let appid:String = UIDevice.currentDevice().identifierForVendor!.UUIDString
        let appName = "OpenCodeApp[\(appid)]"
        var header = NSDictionary()
        header = ["Authorization": authorization, "Content-Type": "application/json"]
        //获取列表
        HttpRequestHelper.sendRequest("https://api.github.com/authorizations", method: HttpRequestMethod.GET, header: header, body: "") { (data:NSData?, resp:NSURLResponse?, error:NSError?) in
            if let _ = resp as? NSHTTPURLResponse{
                let json = JSON(data!)
                let items = json.arrayValue
                var tokenId = 0
                for item in items{
                    if(item["app"]["name"].string! == appName){
                        tokenId = item["id"].int!
                        break
                    }
                }
                
                if(tokenId != 0){
                    //删除
                    HttpRequestHelper.sendRequest("https://api.github.com/authorizations", method: HttpRequestMethod.DELETE, header: header, body: "", completionHandler: { (data:NSData?, resp:NSURLResponse?, error:NSError?) in
                        if let _ = resp as? NSHTTPURLResponse{
                            completionHandler()
                        }else{
                            print("删除失败")
                        }
                    })
                }else{
                    print("没有找到相关的token")
                    completionHandler()
                }
            }else{
                print("登出失败")
            }
        }
    }
    //获取当前用户信息
    class func getCurrentUserInfo(completionHandler:(AnyObject?) -> Void) {
        requestPrivateData("https://api.github.com/user", completionHandler: completionHandler)
    }
    //获取当前用户所有授权
    class func getCurrentUserAuthorizations(completionHandler:(AnyObject?) -> Void){
        requestPrivateData("https://api.github.com/authorizations", completionHandler: completionHandler)
    }
    //获取当前用户的项目列表数据
    class func getCurrentUserRepositories(completionHandler:(AnyObject?) -> Void){
        requestPrivateData("https://api.github.com/user/repos", completionHandler: completionHandler)
    }
    //获取当前用户的收藏
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
    //获取用户数据
    class func getUserInfo(username:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/users/\(username)", completionHandler: completionHandler)
    }
    //获取用户收藏
    class func getUserStarred(username:String, completionHandler:(AnyObject?) -> Void) {
        requestPublicData("https://api.github.com/users/\(username)/starred", completionHandler: completionHandler)
    }
    //获取用户事件
    class func getUserEvents(username:String, completionHandler:(AnyObject?) -> Void) {
        requestPublicData("https://api.github.com/users/\(username)/events", completionHandler: completionHandler)
    }
    //获取用户项目
    class func getUserRepos(username:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/users/\(username)/repos", completionHandler: completionHandler)
    }
    //获取用户组织
    class func getUserOrgs(username:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/users/\(username)/orgs", completionHandler: completionHandler)
    }
    //获取用户Gists数据
    class func getUserGists(username:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/users/\(username)/gists", completionHandler: completionHandler)
    }
    class func getUserGists(username:String, gistId:Int, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/users/\(username)/gists/\(gistId)", completionHandler: completionHandler)
    }
    
    //获取github项目搜索结果
    class func getGithubRepoSearch(query:String, page:Int?, completionHandler:(AnyObject?) -> Void){
        var url:String = "https://api.github.com/search/repositories?q=\(query)"
        if page != nil{
            url += "&page=\(page!)"
        }
        requestPublicData(url, completionHandler: completionHandler)
    }
    //获取github热门项目
    class func getGithubHotSearch(page:Int?, completionHandler:(AnyObject?) -> Void){
        var url:String = "https://api.github.com/search/repositories?sort=stars&order=desc&q=stars:>500"
        if page != nil{
            url += "&page=\(page!)"
        }
        requestPublicData(url, completionHandler: completionHandler)
    }
    class func getGithubHotSearch(page:Int?, withLanguage language:String, completionHandler:(AnyObject?) -> Void){
        var url:String = "https://api.github.com/search/repositories?sort=stars&order=desc&q=stars:>=500+language:\(language)"
        if page != nil{
            url += "&page=\(page!)"
        }
        requestPublicData(url, completionHandler: completionHandler)
    }
    //获取github近期热门项目
    class func getGithubTrending(page:Int?, completionHandler:(AnyObject?) -> Void){
        //获取距今7天时间的字符串
        let now = NSDate()
        let from = NSDate(timeInterval: -7 * 24 * 60 * 60, sinceDate: now)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.stringFromDate(from)
        
        var url = "https://api.github.com/search/repositories?q=stars:>500+pushed:>\(dateStr)&sort=updated"
        if(page != nil){
            url += "&page=\(page!)"
        }
        requestPublicData(url, completionHandler: completionHandler)
    }
    //获取github代码搜索结果
    class func getGithubCodeSearch(query:String, page:Int?, perPage:Int?, sort:Int?, order:Int?, completionHandler:(AnyObject?) -> Void){
        var url:String = "https://api.github.com/search/code?q=\(query)"
        if page != nil{
            url += "&page=\(page!)"
        }
        if perPage != nil{
            url += "&per_page=\(perPage!)"
        }
        if sort != nil{
            url += "&sort=\(sort!)"
        }else{
            url += "&sort=indexed"
        }
        if order != nil{
            url += "&order=\(order!)"
        }else{
            url += "&order=desc"
        }
        requestPublicData(url, completionHandler: completionHandler)
    }
    
    //获取项目基本信息
    class func getRepoInfo(repoFullName:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/repos/\(repoFullName)", completionHandler: completionHandler)
    }
    //获取项目事件
    class func getRepoEvents(repoFullName:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/repos/\(repoFullName)/events",completionHandler: completionHandler)
    }
    //获取项目问题事件
    class func getRepoIssues(repoFullName:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/repos/\(repoFullName)/issues",completionHandler: completionHandler)
    }
    //获取项目内容列表
    class func getRepoContrntList(repoFullName:String, path:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/repos/\(repoFullName)/contents", completionHandler: completionHandler)
    }
    //获取项目内容
    class func getRepoContent(repoFullName:String, path:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/repos/\(repoFullName)/contents/\(path)", completionHandler: completionHandler)
    }
    //获取项目提交纪录
    class func getRepoCommits(repoFullName:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/repos/\(repoFullName)/commits", completionHandler: completionHandler)
    }
    //获取项目提交论评列表
    class func getRepoCommitComments(repoFullName:String, sha:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/repos/\(repoFullName)/commits/\(sha)/comments", completionHandler: completionHandler)
    }
    //获取项目拉取
    class func getRepoPulls(repoFullName:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/repos/\(repoFullName)/pulls", completionHandler: completionHandler)
    }
    class func getRepoBranches(repoFullName:String, completionHandler:(AnyObject?) -> Void){
        requestPublicData("https://api.github.com/repos/\(repoFullName)/branches", completionHandler: completionHandler)
    }
    //获取github名人列表
    class func getNotableList(page:Int?,completionHandler:(AnyObject?) -> Void){
        var url = "https://api.github.com/search/users?q=followers:>1000&sort=followers&order=desc"
        if(page != nil){
            url += "&page=\(page!)"
        }
        requestPublicData(url, completionHandler: completionHandler)
    }
    //获取组织信息
    class func getOrgsInfo(orgsName:String, completionHandler:(AnyObject?) -> Void){
        let url = "https://api.github.com/orgs/\(orgsName)"
        requestPublicData(url, completionHandler: completionHandler)
    }
    //获取组织成员列表
    class func getOrgsMemberList(orgsName:String, completionHandler:(AnyObject?) -> Void){
        let url = "https://api.github.com/orgs/\(orgsName)/members"
        requestPublicData(url, completionHandler: completionHandler)
    }
    //获取组织项目列表
    class func getOrgsRepoList(orgsName:String, completionHandler:(AnyObject?) -> Void){
        let url = "https://api.github.com/orgs/\(orgsName)/repos"
        requestPublicData(url, completionHandler: completionHandler)
    }
    //获取组织事件列表
    class func getOrgsEventList(orgsName:String, completionHandler:(AnyObject?) -> Void){
        let url = "https://api.github.com/orgs/\(orgsName)/events"
        requestPublicData(url, completionHandler: completionHandler)
    }
    //获取组织提问列表
    class func getOrgsIssueList(orgsName:String, completionHandler:(AnyObject?) -> Void){
        let url = "https://api.github.com/orgs/\(orgsName)/issues"
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
        let token = getToken()
        var urlStr = url
        if(token != nil){
            if(urlStr.containsString("?")){
                urlStr += "&access_token=\(token!)"
            }else{
                urlStr += "?access_token=\(token!)"
            }
        }

        HttpRequestHelper.sendRequest(urlStr) { (data:NSData?, resp:NSURLResponse?, error:NSError?) in
            if let d = data{
                completionHandler(self.convertDataToJSONObj(d))
            }else{
                print("\(url): 无法获取数据: resp:\(resp) data:\(data) error:\(error)")
                completionHandler(nil)//TODO 待处理
            }
        }
    }
    //获取私人数据通用方法
    class private func requestPrivateData(url:String, completionHandler:(AnyObject?) -> Void){
        if let token:String = getToken(){
            var urlStr = url
            if(urlStr.containsString("?")){
                urlStr += "&access_token=\(token)"
            }else{
                urlStr += "?access_token=\(token)"
            }
            
            HttpRequestHelper.sendRequest(urlStr, completionHandler: { (data:NSData?, resp:NSURLResponse?, error:NSError?) in
                if let d = data{
                    //completionHandler(self.convertDataToJSONObj(d))
                    completionHandler(d)
                }else{
                    print("\(url): 无法获取数据: resp:\(resp) data:\(data) error:\(error)")
                    completionHandler(nil)//TODO 待处理
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
    
    class func clearToken(){
        let ud = NSUserDefaults.standardUserDefaults()
        ud.removeObjectForKey("GithubToken")
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