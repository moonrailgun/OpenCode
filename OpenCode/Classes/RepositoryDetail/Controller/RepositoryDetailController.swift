//
//  RepositoryDetailController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-5-8.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

class RepositoryDetailController: UIViewController, UITableViewDataSource {
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), style: UITableViewStyle.Grouped)
        tableView!.dataSource = self

        initNavItem()
        initView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initNavItem(){
        self.title = "项目详情"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "查看源码", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    func initView(){
        self.view.addSubview(self.tableView!)
        self.tableView!.layer.borderColor = UIColor.redColor().CGColor
        self.tableView!.backgroundColor = GlobalDefine.BackgroundColor
        self.tableView!.registerClass(RepoDetailHeaderCell.classForCoder(), forCellReuseIdentifier: "header")
        
        self.tableView!.sectionHeaderHeight = 0;
        self.tableView!.sectionFooterHeight = 10;
        //self.tableView!.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
        print(self.tableView?.contentInset)
        
        
        
        /*let headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        headerView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        
        let headerImg:UIImageView = UIImageView(frame: CGRect(x: headerView.frame.width / 2 - 50, y: 25, width: 100, height: 100))
        headerImg.backgroundColor = UIColor(white: 1, alpha: 1)
        headerView.addSubview(headerImg)
        
        let repoTitle:UILabel = UILabel(frame: CGRect(x: 0, y: 130, width: self.view.frame.width, height: 40))
        repoTitle.text = "项目名"
        repoTitle.textColor = UIColor(white: 1, alpha: 1)
        repoTitle.font = UIFont(descriptor: UIFontDescriptor(), size: 20)
        repoTitle.textAlignment = NSTextAlignment.Center
        headerView.addSubview(repoTitle)
        let repoDesc:UILabel = UILabel(frame: CGRect(x: 0, y: 160, width: self.view.frame.width, height: 40))
        repoDesc.text = "描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述"
        repoDesc.numberOfLines = 2
        repoDesc.textColor = UIColor(white: 1, alpha: 1)
        repoDesc.font = UIFont(descriptor: UIFontDescriptor(), size: 14)
        repoDesc.textAlignment = NSTextAlignment.Center
        headerView.addSubview(repoDesc)
        
        self.view.addSubview(headerView)*/
    }

    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("header", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
