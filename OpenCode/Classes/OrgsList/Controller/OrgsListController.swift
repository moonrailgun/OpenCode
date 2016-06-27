//
//  OrgsListController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/26.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class OrgsListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let ORGS_CELL_ID = "orgs"
    lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .Grouped)
    var data:[JSON]?
    
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
        if(self.data != nil){
            return self.data!.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ORGS_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: ORGS_CELL_ID)
            cell?.accessoryType = .DisclosureIndicator
        }
        
        if(self.data != nil){
            let item = self.data![indexPath.row]
            cell?.textLabel?.text = item["login"].string
            if let avatar_url = item["avatar_url"].string{
                //cell?.imageView?.sd_setImageWithURL(NSURL(string: avatar_url))
                cell?.imageView?.sd_setImageWithURL(NSURL(string: avatar_url))
            }
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        if let login = self.data![indexPath.row]["login"].string{
            ProgressHUD.show()
            Github.getOrgsInfo(login, completionHandler: { (data:AnyObject?) in
                let info = JSON(data!)
                
                OperationQueueHelper.operateInMainQueue({
                    ProgressHUD.dismiss()
                    let controller = OrgsDetailController()
                    controller.orgsData = info
                    self.navigationController?.pushViewController(controller, animated: true)
                })
            })
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
