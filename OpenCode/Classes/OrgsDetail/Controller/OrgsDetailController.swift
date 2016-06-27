//
//  OrgsDetailController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/27.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrgsDetailController: UIViewController {

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
        self.view.addSubview(tableView)
        
        let header = OrgsDetailHeaderView()
        if(orgsData != nil){
            header.setData(self.orgsData!)
        }
        tableView.tableHeaderView = header
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
