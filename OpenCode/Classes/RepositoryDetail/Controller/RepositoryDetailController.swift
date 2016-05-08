//
//  RepositoryDetailController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-5-8.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

class RepositoryDetailController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func initView(){
        var headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        headerView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        
        var headerImg:UIImageView = UIImageView(frame: CGRect(x: headerView.frame.width / 2 - 50, y: 25, width: 100, height: 100))
        headerImg.backgroundColor = UIColor(white: 1, alpha: 1)
        headerView.addSubview(headerImg)
        
        var repoTitle:UILabel = UILabel(frame: CGRect(x: 0, y: 130, width: self.view.frame.width, height: 40))
        repoTitle.text = "项目名"
        repoTitle.textColor = UIColor(white: 1, alpha: 1)
        repoTitle.font = UIFont(descriptor: UIFontDescriptor(), size: 20)
        repoTitle.textAlignment = NSTextAlignment.Center
        headerView.addSubview(repoTitle)
        var repoDesc:UILabel = UILabel(frame: CGRect(x: 0, y: 160, width: self.view.frame.width, height: 40))
        repoDesc.text = "描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述"
        repoDesc.numberOfLines = 2
        repoDesc.textColor = UIColor(white: 1, alpha: 1)
        repoDesc.font = UIFont(descriptor: UIFontDescriptor(), size: 14)
        repoDesc.textAlignment = NSTextAlignment.Center
        headerView.addSubview(repoDesc)
        
        self.view.addSubview(headerView)
    }

    /*
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }*/

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
