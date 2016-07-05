//
//  ToolController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/24.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class ToolController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let TOOL_CELL_ID = "tool"
    
    var collectionView:UICollectionView?
    var data:NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        initView()
        initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = ToolCell.size
        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)//section中内容与容器边缘的距离
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.view.addSubview(collectionView!)
        
        //self.collectionView!.registerClass(ToolCell.self, forCellWithReuseIdentifier: TOOL_CELL_ID)
        self.collectionView?.registerNib(UINib(nibName: "ToolCell",bundle: nil), forCellWithReuseIdentifier: TOOL_CELL_ID)
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.backgroundColor = UIColor.clearColor()
    }
    
    func initData(){
        self.data = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("ToolList", ofType: "plist")!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let d = self.data{
            let num = d.count
            
            return num
        }else{
            return 0
        }
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let d = self.data{
            let array = d.allKeys
            if(section > array.count){
                return 0
            }else{
                let key = array[section]
                return d.objectForKey(key)!.count
            }
        }else{
            return 0
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(TOOL_CELL_ID, forIndexPath: indexPath) as! ToolCell
    
        let section = indexPath.section
        let row = indexPath.row
        
        if let d = self.data{
            let sectionName:String = d.allKeys[section] as! String
            
            let toolList = d.valueForKey(sectionName) as! NSDictionary
            let toolData = toolList.valueForKey(toolList.allKeys[row] as! String) as! NSDictionary
            
            let toolName = toolData.valueForKey("Name") as! NSString
            cell.setData(UIImage(named: "code")!, text: toolName as String)
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                print("ping")
                let controller = PingController()
                self.navigationController?.pushViewController(controller, animated: true)
            }else if(indexPath.row == 1){
                print("二维码扫描器")
                let controller = QRCodeController()
                self.navigationController?.pushViewController(controller, animated: true)
            }else if(indexPath.row == 2){
                print("局域网扫描")
                let controller = LANScanController()
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
