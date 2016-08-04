//
//  PingDetailController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/7/6.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON
import FSLineChart

class PingDetailController: UIViewController {
    var hostAddress:String?
    var timer:NSTimer?
    var pingResult:[JSON] = []
    let lineChartView:FSLineChart = FSLineChart(frame: CGRectMake(0,100,UIScreen.mainScreen().bounds.width,60))
    var lineChartData:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        lineChartView.setChartData(lineChartData)
        self.view.addSubview(lineChartView)
        
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
        if let address = hostAddress{
            SimplePingHelper.start(address, target: self, selector: #selector(self.pingResult(_:)))
        }
    }
    
    func pingResult(object:AnyObject){
        let result = JSON(object)
        pingResult.append(result)
        if(result["status"] == true){
            //ping到
            let time = result["time"].int! > 2 ? 2 : result["time"].int!
            print("\(time)ms")
            self.lineChartData.append(time)
        }else{
            //没有
            print(result["error"])
            self.lineChartData.append(2)
        }
        self.lineChartView.clearChartData()
        self.lineChartView.setChartData(self.lineChartData)
        self.lineChartView.animationDuration = 0
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
