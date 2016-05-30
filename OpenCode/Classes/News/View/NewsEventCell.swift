//
//  NewsEventCell.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/30.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

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
    
    func setData(eventName:String, dataStr:String, userAvatarUrl:String, descText:String){
        self.dateLabel.text = dataStr
        if let url = NSURL(string: userAvatarUrl){//判定URL合法性
            self.userAvatarImage.image = UIImage(data: NSData(contentsOfURL: url)!)//需要图片懒加载
        }
        self.descText.text = descText
    }
}
