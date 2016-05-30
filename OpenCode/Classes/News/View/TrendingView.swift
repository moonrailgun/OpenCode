//
//  TrendingView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/30.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class TrendingView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let TRENDING_CELL_ID = "trending"
    lazy var tableView:UITableView = UITableView(frame: self.bounds, style: .Plain)

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        initView()
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        tableView.dataSource = self
        tableView.delegate = self
        self.addSubview(tableView)
    }
    
    func initData(){
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(TRENDING_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: TRENDING_CELL_ID)
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
