//
//  FileBrowserController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/23.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

//文件夹浏览器
class FileBrowserController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let FILE_CELL = "file"
    
    var data:JSON?
    
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if data != nil{
            initView()
        }else{
            print("出现错误")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(data:AnyObject?){
        if let d = data{
            loadData(JSON(d))
        }
    }
    
    func loadData(data:JSON){
        self.data = data
    }
    
    func initView(){
        self.tableView = UITableView(frame: self.view.bounds)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.view.addSubview(tableView!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(FILE_CELL)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Value1, reuseIdentifier: FILE_CELL)
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
