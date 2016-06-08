//
//  MyProfileView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/2.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyProfileView: UIView, UITableViewDataSource {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    let MY_CELL_ID = "my"
    lazy var tableView:UITableView = UITableView(frame: self.bounds, style: .Grouped)
    var userInfo:JSON = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initData(){
        Github.getCurrentUserInfo { (data:AnyObject?) in
            print(JSON(data!))
            OperationQueueHelper.operateInMainQueue({ 
                if let d = data{
                    let json = JSON(d)
                    self.userInfo = json
                    if let header = self.tableView.tableHeaderView as? MyUserInfoHeader{
                        header.setData(NSURL(string: json["avatar_url"].string!)!, username: json["login"].string!)
                    }
                }
            })
        }
    }
    
    func initView(){
        self.addSubview(tableView)
        
        tableView.tableHeaderView = MyUserInfoHeader()
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr = [1,4,1]
        return arr[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(MY_CELL_ID)
        //初始化
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: MY_CELL_ID)
            cell?.accessoryType = .DisclosureIndicator
            
            var model:MyCellDataModel?
            if(indexPath.section == 0){
                model = MyCellDataModel(title: "我的事件", image: "commit")
            }else if(indexPath.section == 1){
                switch indexPath.row {
                case 0:
                    model = MyCellDataModel(title: "我的项目", image: "repo")
                case 1:
                    model = MyCellDataModel(title: "我的收藏", image: "star")
                case 2:
                    model = MyCellDataModel(title: "我的粉丝", image: "team")
                case 3:
                    model = MyCellDataModel(title: "我的关注", image: "team")
                default:
                    model = MyCellDataModel()
                }
            }else if(indexPath.section == 2){
                model = MyCellDataModel(title: "设置", image: "settings")
            }
            cell?.textLabel?.text = model!.title
            cell?.imageView?.image = UIImage(named: model!.image)
        }
        
        return cell!
    }
}
