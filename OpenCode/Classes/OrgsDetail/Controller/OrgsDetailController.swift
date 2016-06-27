//
//  OrgsDetailController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/27.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrgsDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let ORGS_DETAIL_CELL_ID = "OrgsDetail"
    lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .Grouped)
    var orgsData:JSON?
    
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
        tableView.sectionFooterHeight = 10
        tableView.sectionHeaderHeight = 0
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        let header = OrgsDetailHeaderView()
        if(orgsData != nil){
            header.setData(self.orgsData!)
        }
        tableView.tableHeaderView = header
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ORGS_DETAIL_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: ORGS_DETAIL_CELL_ID)
            cell?.accessoryType = .DisclosureIndicator
            
            if(indexPath.section == 0){
                if(indexPath.row == 0){
                    cell?.textLabel?.text = "成员"
                }else if(indexPath.row == 1){
                    cell?.textLabel?.text = "项目"
                }
            }else if(indexPath.section == 1){
                if(indexPath.row == 0){
                    cell?.textLabel?.text = "事件"
                }else if(indexPath.row == 1){
                    cell?.textLabel?.text = "提问"
                }
            }
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
