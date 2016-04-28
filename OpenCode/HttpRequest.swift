//
//  HttpRequest.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-22.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

public protocol ResponseConvertible{
    typealias Result
    class func convertFromData(data:NSData!) -> (Result?,NSError?)
}

extension NSJSONSerialization:ResponseConvertible{
    public typealias Result = AnyObject
    public class func convertFromData(data:NSData!) -> (Result?, NSError?){
        let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        //        switch json.type{
        //        case .Null:
        //            return (value, value.error)
        //        default:
        //            return (value, nil)
        //        }
        return (json,nil)
    }
}

extension NSData:ResponseConvertible{
    public typealias Result = NSData
    public class func convertFromData(data: NSData!) -> (NSData?, NSError?) {
        return (data,nil)
    }
}

extension UIImage:ResponseConvertible{
    public typealias Result = UIImage
    public class func convertFromData(data: NSData!) -> (UIImage?, NSError?) {
        return (UIImage(data: data),nil)
    }
}

/*
发送HTTP网络请求数据
usage:HttpRequest<NSData>.Request("http://baidu.com", {data,error in println("\(data)")})
*/
class HttpDataRequest<T:ResponseConvertible>{
    class func request (url:String, completionHandler:(T.Result?,NSError!) -> Void) {
        let requestUrl = NSURL(string: url)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(requestUrl, completionHandler: {(data, response, error)->Void in
            if error == nil{
                let(object, converError) = T.convertFromData(data)
                completionHandler(object,converError)
            }
        })
        
        task.resume()
    }
}

class HttpRequest{
    /*
    发送HTTP GET请求
    */
    class func sendSyncRequest(url:NSURL) -> (NSData?, NSURLResponse?, NSError?) {
        var resp:NSURLResponse?
        var error:NSError?
        
        var data = NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: url), returningResponse: &resp, error: &error)
        
        return (data, resp, error)
    }
    
    class func sendAsyncRequest(url:NSURL, completionHandler: (NSURLResponse?, NSData?, NSError?)->Void) {
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: url), queue: NSOperationQueue(), completionHandler: completionHandler)
    }
    
    /*
    发送HTTP POST请求
    */
    class func sendAsyncPostRequest(url:NSURL,data:String, completionHandler: (NSURLResponse?, NSData?, NSError?)->Void){
        var req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = "POST"
        req.HTTPBody = NSString(string: data).dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue(), completionHandler: completionHandler)
    }
    
    /*
    发送带http头的POST 请求
    */
    class func sendAsyncPostRequest(url:NSURL,header: NSDictionary ,data:String, completionHandler: (NSURLResponse!, NSData!, NSError!)->Void){
        var req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = "POST"
        //配置头
        for aKey in header.allKeys{
            req.setValue(header.objectForKey(aKey) as? String, forHTTPHeaderField: aKey as String)
        }
        req.HTTPBody = NSString(string: data).dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue(), completionHandler: completionHandler)
    }
}
