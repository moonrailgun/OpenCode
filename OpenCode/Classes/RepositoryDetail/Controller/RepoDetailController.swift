//
//  RepositoryDetailController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-5-8.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class RepoDetailController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    var tableView:UITableView?
    let MY_CELL_ID = "my"
    var isFirstRun = true
    
    var repoDetailData:AnyObject?
    
    var isPrivate:RepoDescView?
    var language:RepoDescView?
    var issuesCount:RepoDescView?
    var branchCount:RepoDescView?//todo
    var date:RepoDescView?
    var size:RepoDescView?
    
    var ownerName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), style: UITableViewStyle.Grouped)
        tableView!.dataSource = self
        tableView!.delegate = self
        
        initNavItem()
        initView()
        loadData()
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "查看源码", style: UIBarButtonItemStyle.Plain, target: self, action: "openSourceCode:")
    }
    
    func openSourceCode(barButtonItem:UIBarButtonItem) {
        print("查看源码")
        if let data = repoDetailData{
            if let repoFullName = JSON(data)["full_name"].string {
                Github.getRepoContent(repoFullName, path: "", completionHandler: { (data:AnyObject?) in
                    let fileBrowser = FileBrowserController()
                    fileBrowser.loadData(repoFullName, data: data)
                    fileBrowser.title = repoFullName
                    OperationQueueHelper.operateInMainQueue({
                        self.navigationController?.pushViewController(fileBrowser, animated: true)
                    })
                })
            }
        }
        
    }
    
    func initView(){
        self.view.backgroundColor = GlobalDefine.defineBackgroundColor
        
        self.view.addSubview(self.tableView!)
        self.tableView!.backgroundColor = GlobalDefine.defineBackgroundColor
        self.tableView!.registerClass(RepoDetailTableViewCell.self, forCellReuseIdentifier: MY_CELL_ID)
        
        self.tableView!.sectionHeaderHeight = 0;
        self.tableView!.sectionFooterHeight = 10;
        //self.tableView!.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
        
        self.tableView!.tableHeaderView = RepoDetailHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200 + 50 + 120))
    }
    
    func loadData() {
        //读取远程数据
        if let data = repoDetailData{
            let json:JSON = JSON(data)
            self.title = json["name"].string//设置标题
            
            
            if self.tableView?.tableHeaderView is RepoDetailHeaderView{
                //配置信息
                let headerView = self.tableView?.tableHeaderView as! RepoDetailHeaderView
                
                let icon:UIImage = UIImage(data: NSData(contentsOfURL: NSURL(string: json["owner"]["avatar_url"].string!)!)!)!
                headerView.setData(icon, repoName: json["full_name"].string, repoDesc: json["description"].string, blockValue1: json["stargazers_count"].int, blockValue2: json["watchers_count"].int, blockValue3: json["forks_count"].int)
                
                //配置描述
                var language:String
                if let l = json["language"].string {
                    language = l
                }else{
                    language = "null"
                }
                
                let issues = json["open_issues_count"].int
                let date = json["created_at"].string
                let isPrivate = json["private"].int
                let size = json["size"].int
                
                headerView.setDescData(isPrivate != 0, language: language, issuesNum: issues!, branchNum: 0, createdDate: date!, size: size!)
                
                self.ownerName = json["owner"]["login"].string
            }
        }
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
        let arr = [1,3,3]
        
        return arr[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MY_CELL_ID, forIndexPath: indexPath) as UITableViewCell
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                //cell = RepoDetailTableViewCell(style: .Value1, reuseIdentifier: MY_CELL_ID)
                
                cell.accessoryType = .DisclosureIndicator
                cell.textLabel?.text = "拥有人"
                cell.imageView?.image = UIImage(named: "box")
                
                let size = cell.bounds
                let detail = UILabel(frame: CGRect(x: size.width - 30 - 100, y: 0, width: 100, height: size.height))
                if let name = self.ownerName{
                    detail.text = name
                }
                detail.textAlignment = .Right
                detail.baselineAdjustment = .AlignCenters
                detail.font = UIFont.systemFontOfSize(14)
                detail.textColor = UIColor(white: 0.4, alpha: 1)
                cell.contentView.addSubview(detail)
                
            default:
                break
            }
        case 1:
            cell.accessoryType = .DisclosureIndicator
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "查看事件"
                cell.imageView?.image = UIImage(named: "box")
            case 1:
                cell.textLabel?.text = "查看提问"
                cell.imageView?.image = UIImage(named: "box")
            case 2:
                cell.textLabel?.text = "README.md"
                cell.imageView?.image = UIImage(named: "box")
            default:
                break
            }
        case 2:
            cell.accessoryType = .DisclosureIndicator
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "提交纪录"
                cell.imageView?.image = UIImage(named: "box")
            case 1:
                cell.textLabel?.text = "拉取请求"
                cell.imageView?.image = UIImage(named: "box")
            case 2:
                cell.textLabel?.text = "查看分支"
                cell.imageView?.image = UIImage(named: "box")
            default:
                break
            }
        default:
            break
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("点击了\(indexPath.row)行")
        
        if(indexPath.section == 0 && indexPath.row == 0){
            //owner
            if let username:String = JSON(self.repoDetailData!)["owner"]["login"].string{
                print("owner:\(username)")
                Github.getUserInfo(username, completionHandler: { (data:AnyObject?) in
                    OperationQueueHelper.operateInMainQueue({
                        if let d = data{
                            let controller = UserInfoController()
                            controller.parseData(d)
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                    })
                })
            }
        }
        
        if let data = repoDetailData{
            if let repoFullName = JSON(data)["full_name"].string {
                if(indexPath.section == 1){
                    if(indexPath.row == 0){
                        //查看事件
                        ProgressHUD.show()
                        Github.getRepoEvents(repoFullName, completionHandler: {(data:AnyObject?) in
                            //print(JSON(data!))
                            OperationQueueHelper.operateInMainQueue({
                                ProgressHUD.dismiss()
                                let controller = RepoEventController()
                                controller.rawData = data
                                self.navigationController?.pushViewController(controller, animated: true)

                            })
                        })
                    }
                    
                    if(indexPath.row == 1){
                        //查看提问
                        ProgressHUD.show()
                        Github.getRepoIssues(repoFullName, completionHandler: {(data:AnyObject?) in
                            //print(JSON(data!))
                            OperationQueueHelper.operateInMainQueue({
                                ProgressHUD.dismiss()
                                let controller = RepoIssuesController()
                                controller.rawData = data
                                self.navigationController?.pushViewController(controller, animated: true)
                            })
                        })
                    }
                    
                    if(indexPath.row == 2){
                        //README.md
                        ProgressHUD.show()
                        Github.getRepoContent(repoFullName, path: "README.md", completionHandler: { (data:AnyObject?) in
                            if let d = data{
                                let json = JSON(d)
                                if(json["message"] == "Not Found"){
                                    OperationQueueHelper.operateInMainQueue({
                                        print("没有readme文件")
                                        ProgressHUD.dismiss()
                                    })
                                }else{
                                    let content = json["content"].string
                                    if let c = content{
                                        let readme = Base64.decrypt(c)
                                        
                                        OperationQueueHelper.operateInMainQueue({
                                            ProgressHUD.dismiss()
                                            let controller = MarkdownReaderController()
                                            controller.setMarkdownStr(readme!)
                                            self.navigationController?.pushViewController(controller, animated: true)
                                        })
                                    }
                                }
                            }
                        })
                    }
                }
                else if(indexPath.section == 2){
                    if(indexPath.row == 0){
                        //提交纪录
                        ProgressHUD.show()
                        Github.getRepoCommits(repoFullName, completionHandler: { (data:AnyObject?) in
                            //print(JSON(data!))
                            OperationQueueHelper.operateInMainQueue({
                                ProgressHUD.dismiss()
                                let controller = RepoCommitsController()
                                controller.rawData = data
                                self.navigationController?.pushViewController(controller, animated: true)
                            })
                        })
                    }else if(indexPath.row == 1){
                        //拉取请求
                        ProgressHUD.show()
                        Github.getRepoPulls(repoFullName, completionHandler: { (data:AnyObject?) in
                            //print(JSON(data!))
                            OperationQueueHelper.operateInMainQueue({
                                ProgressHUD.dismiss()
                                let controller = RepoPullController()
                                controller.rawData = data
                                self.navigationController?.pushViewController(controller, animated: true)
                            })
                        })
                    }else if(indexPath.row == 2){
                        //查看分支
                        ProgressHUD.show()
                        Github.getRepoBranches(repoFullName, completionHandler: { (data:AnyObject?) in
                            //print(JSON(data!))
                            OperationQueueHelper.operateInMainQueue({
                                ProgressHUD.dismiss()
                                let controller = RepoBranchController()
                                controller.rawData = data
                                self.navigationController?.pushViewController(controller, animated: true)
                            })
                        })
                    }
                }
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showUserInfo" {
            if let controller = segue.destinationViewController as? UserInfoController{
                controller.parseData(sender!)
            }
        }
    }
    
}
