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
        tableView?.registerNib(UINib(nibName: "RepoEventCell",bundle: nil), forCellReuseIdentifier: EVENT_CELL_ID)
        tableView?.dataSource = self
        tableView?.delegate = self
        self.view.addSubview(tableView!)
    }
    
    func initData(){
        if let raw = rawData{
            self.data = JSON(raw)
            
            tableView?.reloadData()
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
        let cell = tableView.dequeueReusableCellWithIdentifier(EVENT_CELL_ID, forIndexPath: indexPath) as! RepoEventCell
        
        if let d = self.data{
            let event = d[indexPath.row]
            
            if let imgUrl = event["actor"]["avatar_url"].string{
                cell.imageView?.sd_setImageWithURL(NSURL(string: imgUrl))
            }
            cell.textLabel?.text = event["type"].string
            cell.detailTextLabel?.text = GithubTime(dateStr: event["created_at"].string!).onlyDay()
        }
        
        return cell
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
