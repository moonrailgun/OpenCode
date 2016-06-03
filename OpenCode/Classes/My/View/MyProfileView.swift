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
    lazy var tableView:UITableView = UITableView(frame: self.bounds, style: .Plain)
    var tableDataSource = [MyCellDataModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initData(){
        tableView.dataSource = self
        
        tableDataSource.removeAll()
        tableDataSource.append(MyCellDataModel(title: "我的项目", image: "repo"))
        tableDataSource.append(MyCellDataModel(title: "我的收藏", image: "star"))
        tableDataSource.append(MyCellDataModel(title: "我的粉丝", image: "team"))
        tableDataSource.append(MyCellDataModel(title: "我的关注", image: "team"))
        
        Github.getCurrentUserInfo { (data:AnyObject?) in
            print(JSON(data!))
            OperationQueueHelper.operateInMainQueue({ 
                if let d = data{
                    let json = JSON(d)
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
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(MY_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: MY_CELL_ID)
            let model = self.tableDataSource[indexPath.row]
            
            cell?.textLabel?.text = model.title
            cell?.imageView?.image = UIImage(named: model.image)
            cell?.accessoryType = .DisclosureIndicator
        }
        
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
