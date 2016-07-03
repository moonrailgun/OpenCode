//
//  LANScanController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/7/1.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import PlainPing

class LANScanController: UIViewController {
    let LAN_CELL_ID = "lan"
    var lanAddressList = [LANDevice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.startScan()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startScan(){
        print("尚未完成")
        print("本机IP:\(getIFAddresses())")
        ping("www.baidu.com") { (timeElapsed, error) in
            if let latency = timeElapsed {
                print("latency (ms): \(latency)")
            }
            
            if let error = error {
                print("error: \(error.localizedFailureReason) \(error.localizedDescription)")
            }
        }
    }
    
    func getIFAddresses()->[String]{
        var addresses = [String]()
        
        var ifaddr: UnsafeMutablePointer<ifaddrs> = nil
        if(getifaddrs(&ifaddr) == 0){
            for(var ptr = ifaddr; ptr != nil; ptr = ptr.memory.ifa_next){
                let flags = Int32(ptr.memory.ifa_flags)
                var addr = ptr.memory.ifa_addr.memory
                
                if((flags & (IFF_UP | IFF_RUNNING | IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING)){
                    if(addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6)){
                        var hostname = [CChar](count: Int(NI_MAXHOST), repeatedValue: 0)
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0){
                            if let address = String.fromCString(hostname){
                                addresses.append(address)
                            }
                        }
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return addresses
    }
    
    func ping(hostname:String, completionHandler:(timeElapsed:Double?, error:NSError?) -> Void){
        PlainPing.ping(hostname, withTimeout: 1.0, completionBlock: completionHandler)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
