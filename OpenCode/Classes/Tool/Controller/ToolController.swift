//
//  ToolController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/5/24.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class ToolController: UIViewController, UICollectionViewDataSource {

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
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.view.addSubview(collectionView!)
        
        self.collectionView!.registerClass(ToolCell.self, forCellWithReuseIdentifier: TOOL_CELL_ID)
        self.collectionView?.dataSource = self
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(TOOL_CELL_ID, forIndexPath: indexPath)
    
        let row = indexPath.row
        
        return cell
    }

    // MARK: UICollectionViewDelegate

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
