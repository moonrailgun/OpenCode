//
//  HttpRequestHelper.swift
//  OpenCode
//
//  Created by 陈亮 on 16/7/28.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import Foundation

enum HttpRequestMethod : String{
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
}

class HttpRequestHelper{
    /*
     发送http请求
     */
    class func sendRequest(urlStr:String, completionHandler:(NSData?, NSURLResponse?, NSError?) -> Void){
        let url:NSURL = NSURL(string: urlStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
        let request:NSURLRequest = NSURLRequest(URL: url)
        
        sendRequest(request, completionHandler: completionHandler)
    }
    
    class func sendRequest(urlStr:String,method:HttpRequestMethod, header:NSDictionary, body:String, completionHandler:(NSData?, NSURLResponse?, NSError?) -> Void){
        let url:NSURL = NSURL(string: urlStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method.rawValue
        for aKey in header.allKeys{
            request.setValue(header.objectForKey(aKey) as? String, forHTTPHeaderField: aKey as! String)
        }
        request.HTTPBody = NSString(string: body).dataUsingEncoding(NSUTF8StringEncoding)
        
        sendRequest(request, completionHandler: completionHandler)
    }
    
    class func sendRequest(request:NSURLRequest, completionHandler:(NSData?, NSURLResponse?, NSError?) -> Void){
        let session:NSURLSession = NSURLSession.sharedSession()
        let task:NSURLSessionTask = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()//run
    }
}