//
//  UserListCell.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/23.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserListCell: UICollectionViewCell {

    static let size:CGSize = CGSize(width: 80, height: 100)
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data:JSON){
        let avatar_url = data["avatar_url"].string!
        
        var username = data["login"].string!
        if let name = data["name"].string{
            username = name
        }
        
        image.sd_setImageWithURL(NSURL(string: avatar_url))
        label.text = username
    }
}
