//
//  UserListController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/23.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserListController: UIViewController {

    lazy var collectionView:UserListView = UserListView(frame: self.view.bounds, controller:self)
    var userListData:[JSON]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let data = userListData{
            collectionView.userListData = data
        }
        
        self.view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
