//
//  LANScanController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/7/1.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import LANScanner

class LANScanController: UIViewController,UITableViewDataSource, LANScannerDelegate {
    let LAN_CELL_ID = "lan"
    var devices:[LANDevice] = []
    var scanner:LANScanner?
    lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .Plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "restartScan:")
        
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        self.title = "正在扫描..."
        scanner = LANScanner(delegate: self, continuous: false)
        scanner!.startScan()
        print("开始扫描")
    }
    
    func restartScan(barButtonItem:UIBarButtonItem){
        self.title = "正在扫描..."
        
        self.devices.removeAll()
        self.tableView.reloadData()
        
        self.scanner?.stopScan()
        self.scanner?.startScan()
        print("开始扫描")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(LAN_CELL_ID)
        
        if cell == nil{
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: LAN_CELL_ID)
            cell?.accessoryType = .DisclosureIndicator
        }
        
        let device = self.devices[indexPath.row]
        
        cell?.textLabel?.text = device.hostName
        cell?.detailTextLabel?.text = device.ipAddress
        
        return cell!
    }
    
    func LANScannerDiscovery(device: LANDevice){
        print("设备:\(device.hostName)[\(device.ipAddress)]")
        self.devices.append(device)
        self.tableView.reloadData()
    }
    
    func LANScannerFailed(error: NSError) {
        print(error)
    }
    
    func LANScannerRestarted() {
        print("重新扫描")
        self.devices = []
        self.tableView.reloadData()
    }
    
    func LANScannerFinished() {
        self.title = "扫描完毕"
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
