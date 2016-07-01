//
//  FileBrowserController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/23.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

//文件夹浏览器
class FileBrowserController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let FILE_CELL = "file"
    
    var data:JSON?
    var repoFullName:String?
    
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if data != nil{
            initView()
        }else{
            print("出现错误")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(repoFullName:String?, data:AnyObject?){
        if let d = data{
            loadData(repoFullName, data: JSON(d))
        }
    }
    
    func loadData(repoFullName:String?, data:JSON){
        self.repoFullName = repoFullName
        
        self.data = data
    }
    
    func initView(){
        self.tableView = UITableView(frame: self.view.bounds)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.view.addSubview(tableView!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row
        let fileCell = self.data![index]
        if let type = fileCell["type"].string{
            let path = fileCell["path"].string
            if(type == "file"){
                //打开代码浏览器
                ProgressHUD.show()
                Github.getRepoContent(self.repoFullName!, path: path!, completionHandler: { (data:AnyObject?) in
                    if let d = data{
                        OperationQueueHelper.operateInMainQueue({
                            ProgressHUD.dismiss()
                            
                            let j = JSON(d)
                            
                            if(j["type"] != "file"){
                                print("文件类型出错")
                                return
                            }
                            
                            let codeBrowser = CodeBrowserController()
                            codeBrowser.parseData(j["content"].string!, encoding: j["encoding"].string!)
                            self.navigationController?.pushViewController(codeBrowser, animated: true)
                        })
                    }
                })
            }else if(type == "dir"){
                //继续浏览
                ProgressHUD.show()
                Github.getRepoContent(self.repoFullName!, path: path!, completionHandler: { (data:AnyObject?) in
                    OperationQueueHelper.operateInMainQueue({
                        ProgressHUD.dismiss()
                        let fileBrowser = FileBrowserController()
                        fileBrowser.loadData(self.repoFullName, data: data)
                        fileBrowser.title = path!
                        self.navigationController?.pushViewController(fileBrowser, animated: true)
                    })
                })
            }
        }
        
        print(indexPath)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(FILE_CELL)
        
        if(cell == nil){
            let index = indexPath.row
            let fileCell = self.data![index]
            
            cell = UITableViewCell(style: .Value1, reuseIdentifier: FILE_CELL)
            cell?.accessoryType = .DisclosureIndicator
            cell?.textLabel?.text = fileCell["name"].string
                
            if let size = fileCell["size"].int{
                if(size != 0){
                    //文件
                    cell?.accessoryType = .None
                    cell?.detailTextLabel?.text = size < 1024 ? "\(size)KB" : "\(size / 1024)MB"
                }else{
                    //文件夹
                    
                }
            }
            
        }
        
        return cell!
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
