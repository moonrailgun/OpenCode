//
//  UserEventsController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/7.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserEventsController: UIViewController, UITableViewDataSource {
    let USER_EVENT_CELL_ID = "user_event"
    lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .Plain)
    var eventData:JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(USER_EVENT_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: USER_EVENT_CELL_ID)
            cell?.accessoryType = .DisclosureIndicator
            
            let data = self.eventData[indexPath.row]
            cell?.textLabel?.text = data["type"].string
            cell?.imageView?.sd_setImageWithURL(NSURL(string: data["actor"]["avatar_url"].string!)!)
        }
        
        return cell!
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
