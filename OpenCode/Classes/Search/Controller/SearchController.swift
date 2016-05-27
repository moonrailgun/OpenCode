//
//  SearchController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/27.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UISearchBarDelegate {

    var searchBar:UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: 66))
        self.searchBar?.delegate = self
        self.searchBar?.prompt = "在此输入想要搜索的内容"
        //self.searchBar?.showsCancelButton = true
        
        self.view.addSubview(searchBar!)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchText = searchBar.text!
        print(searchText)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
