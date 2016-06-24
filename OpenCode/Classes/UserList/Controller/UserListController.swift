//
//  UserListController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/23.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class UserListController: UIViewController {

    lazy var collectionView:UserListView = UserListView(frame: self.view.bounds)
    var userListData:AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
