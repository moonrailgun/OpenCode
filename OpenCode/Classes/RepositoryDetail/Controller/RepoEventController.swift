//
//  RepoEventController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/26.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class RepoEventController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let EVENT_CELL_ID = "event"
    
    var tableView:UITableView?
    var rawData:AnyObject?
    var data:JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        tableView = UITableView(frame: self.view.bounds, style: .Plain)
        
        self.view.addSubview(tableView!)
    }
    
    func initData(){
        if let raw = rawData{
            self.data = JSON(raw)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let d = data{
            return d.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(EVENT_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: EVENT_CELL_ID)
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
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
