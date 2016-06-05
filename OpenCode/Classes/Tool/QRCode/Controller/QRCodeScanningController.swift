//
//  QRCodeScanningController.swift
//  OpenCode
//
//  Created by 陈亮 on 16/6/5.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeScanningController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    let QRCODE_SCANNING_ID = "qrcode-scanning"
    
    var session:AVCaptureSession?
    var device:AVCaptureDevice?
    var input:AVCaptureDeviceInput?
    var output:AVCaptureMetadataOutput?
    var layer:AVCaptureVideoPreviewLayer?
    
    var lastScanningResult:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initScanningContent()
        initFrame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initScanningContent(){
        device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        input = try? AVCaptureDeviceInput(device: device)
        output = AVCaptureMetadataOutput()
        output?.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())//设置代理 在主线程里刷新
        session = AVCaptureSession()
        session?.sessionPreset = AVCaptureSessionPresetHigh//高质量采集率
        session?.addInput(input)
        session?.addOutput(output)
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output?.metadataObjectTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
        layer = AVCaptureVideoPreviewLayer(session: session)
        layer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        //设置相机可视范围--全屏
        layer?.frame = self.view.bounds;
        self.view.layer.insertSublayer(layer!, atIndex: 0)
        //开始捕获
        session?.startRunning()
    }
    
    func initFrame(){
        let screenSize = UIScreen.mainScreen().bounds.size
        let scanningRect = CGRectMake(screenSize.width / 7, 114, screenSize.width / 7 * 5, screenSize.width / 7 * 5)
        
        //设置扫描作用域范围(中间透明的扫描框)
        let intertRect = layer?.metadataOutputRectOfInterestForRect(scanningRect)
        output!.rectOfInterest = intertRect!;
        
        //添加全屏的黑色半透明蒙版
        let maskView = UIView(frame: self.view.bounds)
        maskView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.view.addSubview(maskView)
        
        //从蒙版中扣出扫描框那一块
        let maskPath:UIBezierPath = UIBezierPath(rect: self.view.bounds)
        maskPath.appendPath(UIBezierPath(roundedRect: scanningRect, cornerRadius: 1).bezierPathByReversingPath())
        let maskLayer:CAShapeLayer = CAShapeLayer()//蒙板层
        maskLayer.path = maskPath.CGPath
        
        maskView.layer.mask = maskLayer//设置蒙板
        
        //扫描框
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if(metadataObjects.count > 0){
            let metadataObject:AVMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if(metadataObject.stringValue != self.lastScanningResult){
                print("stringValue = \(metadataObject.stringValue)")
                self.lastScanningResult = metadataObject.stringValue
                
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
