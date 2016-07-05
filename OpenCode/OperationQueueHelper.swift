//
//  OperationQueueHelper.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-25.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import Foundation

class OperationQueueHelper {
    class func operateInMainQueue(handler: ()->Void) {
        dispatch_sync(dispatch_get_main_queue(), handler)
    }
    class func operateInGlobalQueue(handler: ()->Void) {
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), handler)
    }
    class func operatorInNewQueue(queueName:String, handler:()->Void) {
        dispatch_async(dispatch_queue_create("com.opencode.\(queueName)", DISPATCH_QUEUE_CONCURRENT), handler)
    }
}
