//
//  NotableList.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/14.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class NotableList: UIView {
    let NOTABLE_CELL_ID = "notable"
    
    var controller:UIViewController?
    var collectionView:UserListView?
    var currentMaxPage = 1
    
    init(frame: CGRect, controller:UIViewController?){
        super.init(frame:frame)
        
        self.controller = controller
        
        initView()
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        collectionView = UserListView(frame: self.bounds, controller: controller)
        collectionView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.currentMaxPage += 1
            self.addonData(self.currentMaxPage)
        })
        self.addSubview(collectionView!)
    }
    
    func initData(){
        if collectionView != nil{
            Github.getNotableList(nil) { (data:AnyObject?) in
                if let d = data{
                    let json = JSON(d)
                    print("共\(json["total_count"].int!)个github名人")
                    let items = json["items"]
                    self.collectionView?.userListData = items.arrayValue
                    
                    OperationQueueHelper.operateInMainQueue({
                        /*let header = UILabel(frame: CGRectMake(0,0,self.bounds.width,24))
                        header.text = "共\(json["total_count"].int!)个名人"
                        header.textColor = UIColor.whiteColor()
                        header.backgroundColor = UIColor.peterRiverFlatColor()
                        header.textAlignment = .Center
                        header.font = UIFont.systemFontOfSize(14)
                        self.collectionView?.addSubview(header)*/
                        self.collectionView?.reloadData()
                    })
                }
            }

        }
    }
    
    func addonData(page:Int){
        if (self.collectionView != nil){
            Github.getNotableList(page) { (data:AnyObject?) in
                if let d = data{
                    let json = JSON(d)
                    print("加载新数据完毕,加载页码\(page)")
                    let items = json["items"]
                    
                    if(self.collectionView?.userListData != nil) {
                        for i in 0 ... items.count - 1{
                            self.collectionView!.userListData!.append(items[i])
                        }
                    }
                    
                    OperationQueueHelper.operateInMainQueue({
                        self.collectionView?.reloadData()
                        self.collectionView?.mj_footer.endRefreshing()
                    })
                }
            }

        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
