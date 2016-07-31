//
//  CommitDetailHeader.swift
//  OpenCode
//
//  Created by 陈亮 on 16/7/30.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class CommitDetailHeaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    let committerAvatar:UIImageView = UIImageView(frame: CGRectMake((UIScreen.mainScreen().bounds.width - 100) / 2, 20, 100, 100))
    let committerName:UILabel = UILabel(frame: CGRectMake(0,110,UIScreen.mainScreen().bounds.width,40))
    let commitDate:UILabel = UILabel(frame: CGRectMake(10,150,200,20))
    let commentCount:UILabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 40, 150, 34, 20))
    let commentCountIcon:UIImageView = UIImageView(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 70, 150, 20, 20))
    let message:UITextView = UITextView(frame: CGRectMake(10, 180, UIScreen.mainScreen().bounds.width - 20, 80))
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 260))
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(committerAvatar)
        
        //提交者名字
        committerName.font = UIFont.systemFontOfSize(16)
        committerName.textAlignment  = .Center
        self.addSubview(committerName)
        
        //提交日期
        commitDate.font = UIFont.systemFontOfSize(14)
        commitDate.textColor = GlobalDefine.iconGrey
        self.addSubview(commitDate)
        
        //评论数
        commentCount.textAlignment = .Right
        commentCount.textColor = GlobalDefine.iconGrey
        self.addSubview(commentCount)
        commentCountIcon.image = UIImage(named: "comment")
        self.addSubview(commentCountIcon)
        
        //批注
        self.addSubview(message)
    }
    
    func setData(avatartUrl:NSURL?, name:String,date:String,commentNum:Int,message:String){
        if(avatartUrl != nil){
            committerAvatar.sd_setImageWithURL(avatartUrl)
        }else{
            //显示默认头像图
            committerAvatar.image = UIImage(named: "github-logo")
        }
        committerName.text = name
        commitDate.text = GithubTime(dateStr: date).long()
        commentCount.text = commentNum>99 ? "99+" : String(commentNum)
        self.message.text = message
    }
}
