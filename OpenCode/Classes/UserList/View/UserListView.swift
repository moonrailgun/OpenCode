//
//  UserListView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/23.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserListView: UICollectionView, UICollectionViewDataSource {
    let USER_LIST_CELL = "userList"
    var userListData:[JSON]?
    
    init(frame:CGRect) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = UserListCell.size
        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)//section中内容与容器边缘的距离
        super.init(frame: frame, collectionViewLayout:flowLayout)
        
        self.backgroundColor = UIColor.whiteColor()
        self.registerNib(UINib(nibName: "UserListCell", bundle: nil), forCellWithReuseIdentifier: USER_LIST_CELL)
        self.dataSource = self
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(){
        if(userListData != nil){
            self.reloadData()
        }
    }
    
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(userListData != nil){
            return userListData!.count
        }else{
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(USER_LIST_CELL, forIndexPath: indexPath)
        
        if(userListData != nil){
            let item = userListData![indexPath.row]
            (cell as! UserListCell).setData(item)
        }
        
        return cell
    }
}
