//
//  File.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-22.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import Foundation


class Github {
    let API_URL = "https://api.github.com/"
    
    class func getEvents() {
        HttpRequest<NSJSONSerialization>.Request("https://api.github.com/events", completionHandler: {data,error in
            println("\(data)")
        })
    }
}