//
//  RepositoryTableViewController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-4-29.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

enum RepositorySource{
    case currentUser, currentStarred
}

class RepositoryTableViewController: UITableViewController {
    let TAG_CELL_LABEL_NAME = 1
    let TAG_CELL_LABEL_DESC = 2
    let TAG_CELL_LABEL_TIME = 3
    let TAG_CELL_LABEL_STAR_NUM = 4
    
    let REPO_CELL_ID = "repositoryCell"
    
    let repositorySource:RepositorySource = RepositorySource.currentUser
    
    var repositoryDataList:JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch repositorySource{
        case .currentUser:
            Github.getCurrentUserRepositories { (data:AnyObject?) -> Void in
                let list = JSON(data!)
                
                self.repositoryDataList = list
                print("加载完毕，共有\(list.count)条项目")
                OperationQueueHelper.operateInMainQueue({ () -> Void in
                    self.tableView.reloadData()
                })
            }
        case .currentStarred:
            print("尚未实现")
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if let list = repositoryDataList{
            return list.count
        }else{
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(REPO_CELL_ID)! as UITableViewCell
        
        // Configure the cell...
        if let list = repositoryDataList{
            let repo = list[indexPath.row]
            
            let nameLabel = cell.viewWithTag(TAG_CELL_LABEL_NAME) as! UILabel
            nameLabel.text = repo["name"].string
            
            let descLabel = cell.viewWithTag(TAG_CELL_LABEL_DESC) as! UILabel
            descLabel.text = repo["description"].string
            
            let timeLabel = cell.viewWithTag(TAG_CELL_LABEL_TIME) as! UILabel
            timeLabel.text = Github.parseGithubTime(repo["pushed_at"].string!)
            
            let starNumLabel = cell.viewWithTag(TAG_CELL_LABEL_STAR_NUM) as! UILabel
            starNumLabel.text = repo["stargazers_count"].int?.description
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath){
            self.performSegueWithIdentifier("showRepositoryDetail", sender: cell)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.tableView.indexPathForSelectedRow{
            if segue.identifier == "showRepositoryDetail"{
                let repoDetail = segue.destinationViewController as! RepositoryDetailController
                if let list = repositoryDataList {
                    repoDetail.repoDetailData = list[indexPath.row].object
                }
            }else if segue.identifier == "showUserList"{
                print("尚未完成")
            }
        }
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
