//
//  AboutController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/13.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class AboutController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let ABOUT_CELL_ID = "about"
    lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .Grouped)
    
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
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ABOUT_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: ABOUT_CELL_ID)
            
            if(indexPath.section == 0){
                cell?.accessoryType = .DisclosureIndicator
                if(indexPath.row == 0){
                    cell?.textLabel?.text = "免责声明"
                }else if(indexPath.row == 1){
                    cell?.textLabel?.text = "关于热门定义"
                }else if(indexPath.row == 2){
                    cell?.textLabel?.text = "关于软件开源"
                }else if(indexPath.row == 3){
                    cell?.textLabel?.text = "开源组件使用许可"
                }
            }
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        
        if(indexPath.section == 0){
            if(indexPath.row == 3){
                if let str = try? NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("ComponentUsage", ofType: "txt")!, encoding: NSUTF8StringEncoding){
                    let controller = ComponentUsageController()
                    controller.text = str as String
                    print(str as String)
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
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
