//
//  RepositoryDetailViewController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-5-1.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class OldRepositoryDetailViewController: UITableViewController {
    
    var repoDetailData:AnyObject?
    @IBOutlet weak var fullNamelabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksNumLabel: UILabel!
    @IBOutlet weak var openIssuesNumLabel: UILabel!
    @IBOutlet weak var pushedTimeLabel: UILabel!
    @IBOutlet weak var watcherNumLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var stargazersNumLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let detail: AnyObject = repoDetailData{
            println("项目详细页参数\(detail)")
        }
        
        updateRepositoryDetail()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateRepositoryDetail(){
        if let detail: AnyObject = repoDetailData{
            let j = JSON(detail)
            self.navigationItem.title = j["name"].description
            
            fullNamelabel.text = j["full_name"].description
            descriptionLabel.text = j["description"].description
            forksNumLabel.text = j["forks_count"].description + " Forks"
            openIssuesNumLabel.text = j["open_issues_count"].description + " Issues"
            pushedTimeLabel.text = j["updated_at"].description
            watcherNumLabel.text = j["watchers"].description + " Watcher"
            createdTimeLabel.text = j["created_at"].description
            stargazersNumLabel.text = j["stargazers_count"].description + " Star"
            languageLabel.text = j["language"].description
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
