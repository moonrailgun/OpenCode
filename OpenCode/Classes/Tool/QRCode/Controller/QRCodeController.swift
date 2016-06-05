//
//  QRCodeController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/5.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit

class QRCodeController: UIViewController {

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
        self.view.backgroundColor = UIColor.whiteColor()
        
        let button = UIButton(type: .System)
        button.frame = CGRectMake(20, 120, 200, 40)
        button.setTitle("扫描二维码", forState: .Normal)
        button.addTarget(self, action: #selector(QRCodeController.enterScanning), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }
    
    //进入二维码调试
    func enterScanning(){
        self.navigationController?.pushViewController(QRCodeScanningController(), animated: true)
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
