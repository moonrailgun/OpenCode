//
//  HttpRequest.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-22.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

class HttpRequest{
    /*
    发送HTTP GET请求
    */
    class func sendSyncRequest(url:NSURL) -> (NSData?, NSURLResponse?, NSError?) {
        var resp:NSURLResponse?
        var error:NSError?
        
        var data: NSData?
        do {
            data = try NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: url), returningResponse: &resp)
        } catch let error1 as NSError {
            error = error1
            data = nil
        }
        
        return (data, resp, error)
    }
    
    class func sendAsyncRequest(url:NSURL, completionHandler: (NSURLResponse?, NSData?, NSError?)->Void) {
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: url), queue: NSOperationQueue(), completionHandler: completionHandler)
    }
    
    class func sendAsyncRequest(url:NSURL, header: NSDictionary, completionHandler: (NSURLResponse?, NSData?, NSError?)->Void) {
        let req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = "GET"
        for aKey in header.allKeys{
            req.setValue(header.objectForKey(aKey) as? String, forHTTPHeaderField: aKey as! String)
        }
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue(), completionHandler: completionHandler)
    }
    
    /*
    发送HTTP POST请求
    */
    class func sendAsyncPostRequest(url:NSURL,data:String, completionHandler: (NSURLResponse?, NSData?, NSError?)->Void){
        let req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = "POST"
        req.HTTPBody = NSString(string: data).dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue(), completionHandler: completionHandler)
    }
    
    /*
    发送带http头的POST 请求
    */
    class func sendAsyncPostRequest(url:NSURL,header: NSDictionary ,data:String, completionHandler: (NSURLResponse?, NSData?, NSError?)->Void){
        let req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = "POST"
        //配置头
        for aKey in header.allKeys{
            req.setValue(header.objectForKey(aKey) as? String, forHTTPHeaderField: aKey as! String)
        }
        req.HTTPBody = NSString(string: data).dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue(), completionHandler: completionHandler)
    }
    
    /*
    发送DELETE请求
    */
    class func sendAsyncDeleteRequest(url:NSURL, completionHandler: (NSURLResponse?, NSData?, NSError?)->Void){
        let req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = "DELETE"
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue(), completionHandler: completionHandler)
    }
    class func sendAsyncDeleteRequest(url:NSURL, header: NSDictionary, completionHandler: (NSURLResponse?, NSData?, NSError?)->Void){
        let req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = "DELETE"
        //配置头
        for aKey in header.allKeys{
            req.setValue(header.objectForKey(aKey) as? String, forHTTPHeaderField: aKey as! String)
        }
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue(), completionHandler: completionHandler)
    }
}
