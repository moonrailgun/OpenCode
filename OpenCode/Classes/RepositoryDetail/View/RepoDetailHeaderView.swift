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
    
    var headerImgView:UIImageView?
    var repoNameLabel:UILabel?
    var repoDescLabel:UILabel?
    
    var infoBlock1:RepoInfoView?
    var infoBlock2:RepoInfoView?
    var infoBlock3:RepoInfoView?
    
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
        
        headerImgView = UIImageView(frame: CGRect(x: headerView.frame.width / 2 - 50, y: 25, width: 100, height: 100))
        //headerImgView!.backgroundColor = UIColor(white: 1, alpha: 1)
        headerView.addSubview(headerImgView!)
        
        self.repoNameLabel = UILabel(frame: CGRect(x: 0, y: 130, width: self.frame.width, height: 40))
        repoNameLabel!.text = ""
        repoNameLabel!.textColor = UIColor(white: 1, alpha: 1)
        repoNameLabel!.font = UIFont(descriptor: UIFontDescriptor(), size: 20)
        repoNameLabel!.textAlignment = NSTextAlignment.Center
        headerView.addSubview(repoNameLabel!)
        self.repoDescLabel = UILabel(frame: CGRect(x: 0, y: 160, width: self.frame.width, height: 40))
        repoDescLabel!.text = ""
        repoDescLabel!.numberOfLines = 2
        repoDescLabel!.textColor = UIColor(white: 1, alpha: 1)
        repoDescLabel!.font = UIFont(descriptor: UIFontDescriptor(), size: 14)
        repoDescLabel!.textAlignment = NSTextAlignment.Center
        headerView.addSubview(repoDescLabel!)
        
        let infoBlockWidth = floor(frame.width / 3)
        let infoBlockSpace = (frame.width - infoBlockWidth * 3)/2
        self.infoBlock1 = RepoInfoView(frame: CGRectMake(0, 200, infoBlockWidth, 40), name: "Stargazers", value: 1)
        self.infoBlock2 = RepoInfoView(frame: CGRectMake(infoBlockWidth * 1 + infoBlockSpace * 1, 200, infoBlockWidth, 40), name: "Watchers", value: 3)
        self.infoBlock3 = RepoInfoView(frame: CGRectMake(infoBlockWidth * 2 + infoBlockSpace * 2, 200, infoBlockWidth, 40), name: "Forks", value: 5)
        self.addSubview(infoBlock1!)
        self.addSubview(infoBlock2!)
        self.addSubview(infoBlock3!)
        
        self.addSubview(headerView)
    }
    
    func setData(icon:UIImage?, repoName:String?, repoDesc:String?, blockValue1:Int?, blockValue2:Int?, blockValue3:Int?){
        self.headerImgView?.image = icon
        self.repoNameLabel?.text = repoName
        self.repoDescLabel?.text = repoDesc
        self.infoBlock1?.setValue(blockValue1!)
        self.infoBlock2?.setValue(blockValue2!)
        self.infoBlock3?.setValue(blockValue3!)
    }
}
