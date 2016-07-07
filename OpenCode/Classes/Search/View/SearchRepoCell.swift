//
//  SearchRepoCell.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/28.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchRepoCell: UITableViewCell {
    
    var data:JSON?

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var starNumLabel: UILabel!
    @IBOutlet weak var forkNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func setData(item:JSON){
        self.data = item
        
        self.fullNameLabel.text = item["full_name"].string
        self.descriptionText.text = item["description"].string
        self.languageLabel.text = item["language"].string
        self.updateTimeLabel.text = GithubTime(dateStr: item["updated_at"].string!).onlyDay()
        self.starNumLabel.text = "\(item["stargazers_count"].int!) Stars"
        self.forkNumLabel.text = "\(item["forks"].int!) Forks"
    }
    
}
