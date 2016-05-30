//
//  NewsEventListView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/29.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsEventListView: UIView, UITableViewDataSource, UITableViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let NEWS_EVENT_CELL_ID = "newsEvent"
    var tableView:UITableView?
    var dataArr:JSON?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        /*
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 40))
        label.text = "画面"
        self.addSubview(label)*/
        initView()
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initView(){
        self.tableView = UITableView(frame: self.bounds, style: .Plain)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.rowHeight = 90
        tableView?.registerNib(UINib(nibName: "NewsEventCell", bundle: nil), forCellReuseIdentifier: NEWS_EVENT_CELL_ID)
        self.addSubview(tableView!)
    }
    func initData(){
        Github.getEvents { (data:AnyObject?) -> Void in
            let json = JSON(data!)
            self.dataArr = json
            print("github事件 数据加载完毕")
            if json.count > 0{
                OperationQueueHelper.operateInMainQueue({ () -> Void in
                    //todo 刷新列表数据
                    self.tableView!.reloadData()
                })
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let d = dataArr{
            return d.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(NEWS_EVENT_CELL_ID)
        
        if(cell == nil){
            cell = NewsEventCell(style: .Default, reuseIdentifier: NEWS_EVENT_CELL_ID)
        }
        
        return cell!
    }
}
