//
//  SearchController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/27.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    let SEARCH_CELL_ID = "search"
    
    var searchBar:UISearchBar?
    var searchResultTable:UITableView?
    
    var searchResult:JSON?
    
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
        
        self.searchResultTable = UITableView(frame: self.view.bounds, style: .Plain)
        self.searchResultTable?.dataSource = self
        self.searchResultTable?.delegate = self
        self.searchResultTable?.tableHeaderView = self.searchBar!
        self.searchResultTable?.registerNib(UINib(nibName: "SearchRepoCell", bundle: nil) , forCellReuseIdentifier: SEARCH_CELL_ID)
        self.searchResultTable?.rowHeight = 130;
        
        self.view.addSubview(searchResultTable!)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchText = searchBar.text!
        print("搜索文本:\(searchText)")
        
        self.searchBar!.resignFirstResponder()
        
        Github.getGithubRepoSearch(searchText, page: nil) { (data:AnyObject?) in
            if let d = data{
                let json = JSON(d)
                //let totalCount = json["total_count"].string!
                let items = json["items"]
                self.searchResult = items
                
                OperationQueueHelper.operateInMainQueue({ 
                    self.searchResultTable?.reloadData()
                })
            }
        }
    }
    
    // tableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchResult != nil && searchResult?.count != nil){
            return searchResult!.count
        }else{
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(SEARCH_CELL_ID)
        
        //初始化cell
        if(cell == nil){
            cell = SearchRepoCell(style: .Default, reuseIdentifier: SEARCH_CELL_ID)
        }
        
        if(searchResult != nil){
            let item = searchResult![indexPath.row]
            (cell as! SearchRepoCell).setData(item)
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        if(self.searchResult != nil){
            let item = self.searchResult![indexPath.row]
            if let fullName = item["full_name"].string {
                Github.getRepoInfo(fullName, completionHandler: { (data:AnyObject?) in
                    OperationQueueHelper.operateInMainQueue({ 
                        let controller = RepoDetailController()
                        controller.repoDetailData = data
                        self.navigationController?.pushViewController(controller, animated: true)
                    })
                })
            }
        }
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
