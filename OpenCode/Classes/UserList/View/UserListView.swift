//
//  UserListView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/23.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class UserListView: UICollectionView, UICollectionViewDataSource {
    let USER_LIST_CELL = "userList"
    
    init(frame:CGRect) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout:layout)
        
        self.registerNib(UINib(nibName: "UserListCell", bundle: nil), forCellWithReuseIdentifier: USER_LIST_CELL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func numberOfSections() -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}
