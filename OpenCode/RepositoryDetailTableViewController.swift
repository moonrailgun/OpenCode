//
//  RepositoryDetailTableViewController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-5-3.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class RepositoryDetailTableViewController: UITableViewController {

    var repoDetailData:AnyObject?
    @IBOutlet weak var repositoryHeaderImg: UIImageView!
    @IBOutlet weak var fullNamelabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var watcherNumLabel: UILabel!
    @IBOutlet weak var stargazersNumLabel: UILabel!
    @IBOutlet weak var forksNumLabel: UILabel!
    @IBOutlet weak var isPublicLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var openIssuesNumLabel: UILabel!
    @IBOutlet weak var branchNumLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var RepositorySizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let detail: AnyObject = repoDetailData{
            print("项目详细页参数\(detail)")
        }
        
        updateRepositoryDetail()

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
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        let rowInSection = [2,4,2,3]
        
        return rowInSection[section]
    }
    
    func updateRepositoryDetail(){
        if let detail: AnyObject = repoDetailData{
            let j = JSON(detail)
            self.navigationItem.title = j["name"].description
            /*
            fullNamelabel.text = j["full_name"].description
            descriptionLabel.text = j["description"].description
            forksNumLabel.text = j["forks_count"].description + " Forks"
            openIssuesNumLabel.text = j["open_issues_count"].description + " Issues"
            pushedTimeLabel.text = j["updated_at"].description
            watcherNumLabel.text = j["watchers"].description + " Watcher"
            createdTimeLabel.text = j["created_at"].description
            stargazersNumLabel.text = j["stargazers_count"].description + " Star"
            languageLabel.text = j["language"].description*/
        }
    }

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
