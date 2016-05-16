//
//  UserCell.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/16.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(image:UIImage, name:String){
        self.userImage.image = image
        self.userName.text = name
    }
}
