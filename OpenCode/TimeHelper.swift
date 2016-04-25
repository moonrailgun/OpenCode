//
//  TimeHelper.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-25.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import Foundation

extension NSDate {
    class func parseWithFormatString(string:String, formatString: String) -> NSDate?{
        let formatter = NSDateFormatter()
        formatter.dateFormat = formatString
        let date = formatter.dateFromString(string)
        
        return date
    }
    
    class func parseWithFormatter(string:String, formatter: NSDateFormatter) -> NSDate?{
        let date = formatter.dateFromString(string)
        return date
    }
}