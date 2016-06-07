//
//  GithubTime.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/7.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import Foundation

class GithubTime{
    let rawDateStr:String
    var date:NSDate?
    init(dataStr raw:String){
        self.rawDateStr = raw
        
        parse()
    }
    
    func parse(){
        let formatter = NSDateFormatter()
        //formatter.timeZone = NSTimeZone(name: "Asia/Shanghai")
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 8 * 60 * 60)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.date = NSDate.parseWithFormatter(self.rawDateStr, formatter: formatter)
    }
    
    func format(formatter:String) -> String{
        if(date == nil){
            parse()
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = formatter
        let timeStr = dateFormatter.stringFromDate(date!)
        
        return timeStr
    }
    
    func long()->String{
        return format("yyyy-MM-dd HH:mm:ss")
    }
    func short()->String{
        return format("HH:mm:ss")
    }
    func onlyDay()->String{
        return format("yyyy-MM-dd")
    }
    func interval()->String{
        if(date == nil){
            parse()
        }
        
        let now = NSDate()
        let second = now.timeIntervalSinceDate(date!)
        let minute = floor(second / 60)
        let hour = floor(minute / 60)
        let day = floor(hour / 24)
        if(day > 0){
            return "\(Int(day))天前"
        }else if(hour > 0){
            return "\(Int(hour))小时前"
        }else if(minute > 0){
            return "\(Int(minute))分钟前"
        }else if(second>0){
            return "\(Int(second))秒前"
        }else{
            return "刚刚"
        }
    }
}