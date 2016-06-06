//
//  NewsEventCell.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/30.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SDWebImage

class NewsEventCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var descText: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(eventName:String, dateStr:String, userAvatarUrl:String, descText:String){
        let imageName = getEventIcon(eventName)
        if (imageName != "") {
            self.eventImage.image = UIImage(named: imageName)
        }else{
            print("未知的图标事件\(eventName)")
        }
        
        self.dateLabel.text = dateStr
        if let url = NSURL(string: userAvatarUrl){//判定URL合法性
            self.userAvatarImage.sd_setImageWithURL(url, placeholderImage: UIImage())
        }
        self.descText.text = descText
    }
    
    //返回事件图标
    func getEventIcon(eventName:String) -> String{
        switch eventName {
        case "ForkEvent":
            return "fork"
        case "CreateEvent":
            return "repo"
        case "GollumEvent":
            return "repo"
        case "DeleteEvent":
            return "deleted"
        case "PullRequestEvent":
            return "merge"
        case "PushEvent":
            return "commit"
        case "IssueCommentEvent":
            return "comment"
        case "IssuesEvent":
            return "comment"
        case "WatchEvent":
            return "watch"
        default:
            return ""
        }
    }
}
