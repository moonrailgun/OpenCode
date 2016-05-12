//
//  RepositoryDetailViewController.swift
//  OpenCode
//
//  Created by 陈亮 on 16-5-7.
//  Copyright (c) 2016年 moonrailgun. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        headerView.backgroundColor = UIColor(white: 1, alpha: 1)
        //self.view.addSubview(headerView)
        
        let headerImageView = UIImageView(frame: CGRect(x: /*self.view.frame.width / 2 - 50*/ 20, y: 0, width: 100, height: 100))
        headerImageView.image = UIImage(named: "Box")
        headerImageView.tintColor = UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 1)
        self.view.addSubview(headerImageView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
