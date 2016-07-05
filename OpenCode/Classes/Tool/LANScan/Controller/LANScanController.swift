//
//  LANScanController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/7/1.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import LANScanner

class LANScanController: UIViewController, LANScannerDelegate {
    let LAN_CELL_ID = "lan"
    
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
        let scanner = LANScanner(delegate: self, continuous: false)
        scanner.startScan()
    }
    
    func isIpAddressValid(ipAddress:NSString)->Bool{
        var pin = in_addr()
        let success = inet_aton(ipAddress.UTF8String, &pin);
        if (success == 1) {
            return true;
        }else{
            return false;
        }
    }
    
    func LANScannerDiscovery(device: LANDevice){
        print("设备:\(device.hostName)[\(device.ipAddress)]")
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
