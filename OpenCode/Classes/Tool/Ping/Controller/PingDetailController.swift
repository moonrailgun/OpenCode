//
//  PingDetailController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/7/6.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class PingDetailController: UIViewController {
    var hostAddress:String?
    var timer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(self.ping), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if(timer != nil){
            startPing()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        if(timer != nil){
            stopPing()
        }
    }
    
    func startPing(){
        self.timer?.fire()
    }
    
    func stopPing(){
        self.timer?.invalidate()
    }
    
    func ping() {
        print("a")
        if let address = hostAddress{
            SimplePingHelper.start(address, target: self, selector: #selector(self.pingResult(_:)))
        }
    }
    
    func pingResult(object:AnyObject){
        let result = JSON(object)
        if(result["status"] == true){
            //ping到
            print(result["time"])
        }else{
            //没有
            print(result["error"])
        }
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
