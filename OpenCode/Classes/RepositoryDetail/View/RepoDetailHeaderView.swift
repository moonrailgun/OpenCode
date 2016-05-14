//
//  RepoDetailHeaderView.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/14.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class RepoDetailHeaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initView(){
        let headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 200))
        headerView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        
        let headerImg:UIImageView = UIImageView(frame: CGRect(x: headerView.frame.width / 2 - 50, y: 25, width: 100, height: 100))
        headerImg.backgroundColor = UIColor(white: 1, alpha: 1)
        headerView.addSubview(headerImg)
        
        let repoTitle:UILabel = UILabel(frame: CGRect(x: 0, y: 130, width: self.frame.width, height: 40))
        repoTitle.text = "项目名"
        repoTitle.textColor = UIColor(white: 1, alpha: 1)
        repoTitle.font = UIFont(descriptor: UIFontDescriptor(), size: 20)
        repoTitle.textAlignment = NSTextAlignment.Center
        headerView.addSubview(repoTitle)
        let repoDesc:UILabel = UILabel(frame: CGRect(x: 0, y: 160, width: self.frame.width, height: 40))
        repoDesc.text = "描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述"
        repoDesc.numberOfLines = 2
        repoDesc.textColor = UIColor(white: 1, alpha: 1)
        repoDesc.font = UIFont(descriptor: UIFontDescriptor(), size: 14)
        repoDesc.textAlignment = NSTextAlignment.Center
        headerView.addSubview(repoDesc)
        
        self.addSubview(headerView)
    }
}