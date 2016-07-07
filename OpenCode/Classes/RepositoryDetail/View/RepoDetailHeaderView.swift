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
    
    var repoDesc1:RepoDescView?//isPrivate
    var repoDesc2:RepoDescView?//language
    var repoDesc3:RepoDescView?//issues num
    var repoDesc4:RepoDescView?//branch num
    var repoDesc5:RepoDescView?//create data
    var repoDesc6:RepoDescView?//size
    
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
        
        //信息部分
        let infoBlockWidth = floor(frame.width / 3)
        let infoBlockSpace = (frame.width - infoBlockWidth * 3)/2
        self.infoBlock1 = RepoInfoView(frame: CGRectMake(0, 200, infoBlockWidth, 40), name: "Stargazers", value: 1)
        self.infoBlock2 = RepoInfoView(frame: CGRectMake(infoBlockWidth * 1 + infoBlockSpace * 1, 200, infoBlockWidth, 40), name: "Watchers", value: 3)
        self.infoBlock3 = RepoInfoView(frame: CGRectMake(infoBlockWidth * 2 + infoBlockSpace * 2, 200, infoBlockWidth, 40), name: "Forks", value: 5)
        self.addSubview(infoBlock1!)
        self.addSubview(infoBlock2!)
        self.addSubview(infoBlock3!)
        
        //描述部分
        let descStartY:CGFloat = 250
        let descWidth =  floor(frame.width / 2)
        let descHeight:CGFloat = 40
        self.repoDesc1 = RepoDescView(frame: CGRectMake(0, descStartY + descHeight*0, descWidth, 40), icon: UIImage(named: "watch")!, desc: "")
        repoDesc1!.backgroundColor = UIColor.whiteColor()
        self.repoDesc2 = RepoDescView(frame: CGRectMake(descWidth, descStartY + descHeight*0, descWidth, 40), icon: UIImage(named: "code")!, desc: "")
        repoDesc2!.backgroundColor = UIColor.whiteColor()
        self.repoDesc3 = RepoDescView(frame: CGRectMake(0, descStartY + descHeight*1, descWidth, 40), icon: UIImage(named: "comment")!, desc: "")
        repoDesc3!.backgroundColor = UIColor.whiteColor()
        self.repoDesc4 = RepoDescView(frame: CGRectMake(descWidth, descStartY + descHeight*1, descWidth, 40), icon: UIImage(named: "fork")!, desc: "")
        repoDesc4!.backgroundColor = UIColor.whiteColor()
        self.repoDesc5 = RepoDescView(frame: CGRectMake(0, descStartY + descHeight*2, descWidth, 40), icon: UIImage(named: "tag")!, desc: "")
        repoDesc5!.backgroundColor = UIColor.whiteColor()
        self.repoDesc6 = RepoDescView(frame: CGRectMake(descWidth, descStartY + descHeight*2, descWidth, 40), icon: UIImage(named: "repo")!, desc: "")			
        repoDesc6!.backgroundColor = UIColor.whiteColor()
        self.addSubview(repoDesc1!)
        self.addSubview(repoDesc2!)
        self.addSubview(repoDesc3!)
        self.addSubview(repoDesc4!)
        self.addSubview(repoDesc5!)
        self.addSubview(repoDesc6!)
        
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
    
    func setDescData(isPrivate:Bool, language:String, issuesNum:Int, branchNum:Int, createdDate:String, size:Int){
        self.repoDesc1?.descLabel.text = isPrivate ? "Private" : "Public"
        self.repoDesc2?.descLabel.text = language
        self.repoDesc3?.descLabel.text = "\(issuesNum) Issues"
        self.repoDesc4?.descLabel.text = "\(branchNum) Branch"
        self.repoDesc5?.descLabel.text = GithubTime(dateStr: createdDate).onlyDay()
        self.repoDesc6?.descLabel.text = size > 1024 ? "\(String(format: "%.2f", Float(size) / 1024))MB":"\(size)KB"
    }
}
