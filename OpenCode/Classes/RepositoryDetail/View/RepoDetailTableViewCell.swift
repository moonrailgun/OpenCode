//
//  RepoDetailTableViewCell.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/14.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class RepoDetailTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.font = UIFont.systemFontOfSize(14)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.imageView!.image == nil{
            return
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
