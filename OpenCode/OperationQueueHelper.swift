//
//  OperationQueueHelper.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-25.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import Foundation

class OperationQueueHelper {
    class func operationInMainQueue(handler: ()->Void) {
        dispatch_sync(dispatch_get_main_queue(), handler)
    }
}