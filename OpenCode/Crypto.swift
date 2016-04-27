//
//  Crypto.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-27.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import Foundation

class Base64 {
    class func encrypt(plain: String) -> String?{
        let plainData = plain.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        let base64Str = plainData?.base64EncodedStringWithOptions(.allZeros)
        return base64Str
    }
    
    class func decrypt(base64:String) -> String?{
        //let decodedData = NSData
        let decodedData = NSData(base64EncodedString: base64, options: .allZeros)
        let decodedString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)
        return decodedString
    }
}