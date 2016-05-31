//
//  HotRepoView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/31.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class HotRepoView: UIView {
    
    lazy var tableView:UITableView = UITableView(frame: self.bounds, style: .Plain)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        let label:UILabel = UILabel(frame: CGRect(x: 20, y: 20, width: 120, height: 40))
        label.text = "热门页"
        
        self.addSubview(label)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
