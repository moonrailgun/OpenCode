//
//  MyController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/31.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class MyController: UIViewController, UITableViewDataSource {
    let MY_CELL_ID = "my"
    
    var tableDataSource = [MyCellDataModel]()
    lazy var tableView:UITableView = UITableView(frame: self.view.bounds, style: .Plain)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let _:String = Github.getToken() {
            //显示正常页
            //initProfileView()
            initLoginView()
        }else{
            //显示登陆页面
            initLoginView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initLoginView(){
        self.view.addSubview(MyLoginView(frame: self.view.bounds))
    }
    
    func initProfileView(){
        tableView.dataSource = self
        
        tableDataSource.removeAll()
        tableDataSource.append(MyCellDataModel(title: "我的项目", image: ""))
        tableDataSource.append(MyCellDataModel(title: "我的收藏", image: ""))
        tableDataSource.append(MyCellDataModel(title: "我的粉丝", image: ""))
        tableDataSource.append(MyCellDataModel(title: "我的关注", image: ""))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(MY_CELL_ID)
        
        if(cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: MY_CELL_ID)
            let model = self.tableDataSource[indexPath.row]
            
            cell?.textLabel?.text = model.title
            cell?.imageView?.image = UIImage(named: model.image)
        }
        
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
