//
//  ViewController.swift
//  QRCodeGen
//
//  Created by Stoner Wang on 15/11/3.
//  Copyright © 2015年 Nuces Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtSource: UITextField!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    var qrcodeImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func performButtonAction(sender: AnyObject) {
        if qrcodeImage == nil {
            if txtSource.text == "" {
                return
            }
            
            // 生成QR Code，有下面这4行就够了
            let data = txtSource.text?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            // 指定容错级别
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter?.outputImage
            
            displayQRCodeImage()
            
            txtSource.resignFirstResponder()
            
            btnAction.setTitle("Clear", forState: .Normal)
        } else {
            qrcodeImage = nil
            imgQRCode.image = nil
            txtSource.text = ""
            slider.value = 1
            changeImageViewScale(slider)
            btnAction.setTitle("Generate", forState: .Normal)
        }
        
        txtSource.enabled = !txtSource.enabled
        slider.hidden = !slider.hidden
    }
    
    @IBAction func changeImageViewScale(sender: AnyObject) {
        imgQRCode.transform = CGAffineTransformMakeScale(CGFloat(slider.value), CGFloat(slider.value))
    }
    
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        imgQRCode.image = UIImage(CIImage: transformedImage)
    }

}

