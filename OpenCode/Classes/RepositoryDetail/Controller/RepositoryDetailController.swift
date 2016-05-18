//
//  RepositoryDetailController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-5-8.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class RepositoryDetailController: UIViewController, UITableViewDataSource,UITableViewDelegate {
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "查看源码", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    func initView(){
        self.view.backgroundColor = GlobalDefine.defineBackgroundColor
        
        self.view.addSubview(self.tableView!)
        self.tableView!.backgroundColor = GlobalDefine.defineBackgroundColor
        self.tableView!.registerClass(RepoDetailTableViewCell.self, forCellReuseIdentifier: MY_CELL_ID)
        
        self.tableView!.sectionHeaderHeight = 0;
        self.tableView!.sectionFooterHeight = 10;
        //self.tableView!.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
        
        self.tableView!.tableHeaderView = RepoDetailHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200 + 50))
    }
    
    func loadData() {
        //读取远程数据
        if let data = repoDetailData{
            let json:JSON = JSON(data)
            self.title = json["name"].string//设置标题
            
            //配置headerView
            if self.tableView?.tableHeaderView is RepoDetailHeaderView{
                let headerView = self.tableView?.tableHeaderView as! RepoDetailHeaderView
                
                let icon:UIImage = UIImage(data: NSData(contentsOfURL: NSURL(string: json["owner"]["avatar_url"].string!)!)!)!
                headerView.setData(icon, repoName: json["full_name"].string, repoDesc: json["description"].string, blockValue1: json["stargazers_count"].int, blockValue2: json["watchers_count"].int, blockValue3: json["forks_count"].int)
            }
            
            /* TODO 将描述块不放在列表中
            //配置cell
            let language = json["language"].string
            let issues = json["open_issues_count"].int
            let date = json["created_at"].string
            let isPrivate = json["private"].int
            let size = json["size"].int
            
            self.isPrivate?.descLabel.text = isPrivate == 0 ? "Public" : "Private"
            self.language?.descLabel.text = language
            self.issuesCount?.descLabel.text = "\(issues) Issues"
            self.branchCount?.descLabel.text = "1 Branch"
            self.date?.descLabel.text = Github.parseGithubTime(date!)
            self.size?.descLabel.text = size! > 1024 ? "\(size! / 1024)MB":"\(size)KB"*/
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
        let arr = [4,3,3]
        
        return arr[section]
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MY_CELL_ID, forIndexPath: indexPath) as UITableViewCell
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                if self.isFirstRun{
                    self.isPrivate = RepoDescView(frame: CGRectMake(0, 0, cell.frame.width / 2, cell.frame.height), icon: UIImage(named: "box")!, desc: "Public")
                    cell.addSubview(isPrivate!)
                    self.language = RepoDescView(frame: CGRectMake(cell.frame.width / 2, 0, cell.frame.width / 2, cell.frame.height), icon: UIImage(named: "box")!, desc: "C#")
                    cell.addSubview(language!)
                }
            case 1:
                if self.isFirstRun{
                    self.issuesCount = RepoDescView(frame: CGRectMake(0, 0, cell.frame.width / 2, cell.frame.height), icon: UIImage(named: "box")!, desc: "1 Issue")
                    cell.addSubview(self.issuesCount!)
                    self.branchCount = RepoDescView(frame: CGRectMake(cell.frame.width / 2, 0, cell.frame.width / 2, cell.frame.height), icon: UIImage(named: "box")!, desc: "1 Branch")
                    cell.addSubview(self.branchCount!)
                }
            case 2:
                if self.isFirstRun{
                    self.date = RepoDescView(frame: CGRectMake(0, 0, cell.frame.width / 2, cell.frame.height), icon: UIImage(named: "box")!, desc: "03/13/15")
                    cell.addSubview(self.date!)
                    self.size = RepoDescView(frame: CGRectMake(cell.frame.width / 2, 0, cell.frame.width / 2, cell.frame.height), icon: UIImage(named: "box")!, desc: "140.9MB")
                    cell.addSubview(self.size!)
                    
                    self.isFirstRun = false//顺序绘制最后一项
                }
            case 3:
                //cell = RepoDetailTableViewCell(style: .Value1, reuseIdentifier: MY_CELL_ID)
                
                cell.accessoryType = .DisclosureIndicator
                cell.textLabel?.text = "拥有人:moonrailgun"
                cell.imageView?.image = UIImage(named: "box")
                
            default:
                break
            }
        case 1:
            cell.accessoryType = .DisclosureIndicator
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "事件"
                cell.imageView?.image = UIImage(named: "box")
            case 1:
                cell.textLabel?.text = "提问"
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
                cell.textLabel?.text = "源码文件"
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
        
        if(indexPath.section == 0 && indexPath.row == 3){
            //owner
            let username:String = JSON(self.repoDetailData!)["owner"]["login"].string!
            print("owner:\(username)")
            Github.getUserInfo(username, completionHandler: { (data:AnyObject?) in
                print(data)
                OperationQueueHelper.operateInMainQueue({ 
                    self.performSegueWithIdentifier("showUserInfo", sender: data)
                })
            })
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
