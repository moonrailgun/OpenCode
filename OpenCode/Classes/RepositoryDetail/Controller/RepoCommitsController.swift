//
//  RepoCommitsController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/27.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class RepoCommitsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let COMMIT_CELL_ID = "commit"
    
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
        var cell = tableView.dequeueReusableCellWithIdentifier(COMMIT_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: COMMIT_CELL_ID)
        }
        
        if let d = self.data{
            let commit = d[indexPath.row]["commit"]
            cell?.textLabel?.text = commit["committer"]["name"].string
            cell?.detailTextLabel?.text = commit["message"].string
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        
        if let d = self.data{
            print(d)
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
