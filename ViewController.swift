//
//  ViewController.swift
//  Qrcode
//
//  Created by YJ Huang on 2019/5/21.
//  Copyright © 2019 YJ Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var qrCodeResult: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func qrcodeGenerate(_ sender: Any) {
        
        
        let inputUrl = "https://www.appcoda.com.tw/qr-code-generator-tutorial/"
        let  data = inputUrl.data(using: .utf8, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        if let qrCodeImge = filter?.outputImage {
            let colorFilter = self.setQrcodeColor(qrCode: qrCodeImge)
            let colorFulImage = colorFilter.outputImage
            
            let scaleX = self.qrCodeResult.frame.size.width / qrCodeImge.extent.size.width
            let scaleY = self.qrCodeResult.frame.size.height / qrCodeImge.extent.size.height
            if  let transformedImage = colorFulImage?.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY)) {
                let image = UIImage(ciImage: transformedImage)
                
                self.qrCodeResult.image = drawIconInQrcode(IconName: "hk.jpg", crCodeImage: image)
                
                self.inputText.resignFirstResponder()
            }
        }
        
    }
    
    func drawIconInQrcode(IconName: String, crCodeImage: UIImage) -> UIImage? {
        
        if let iconImage = UIImage(named: IconName) {
            let qrcodeRect = CGRect(x:0, y:0, width:crCodeImage.size.width,height:crCodeImage.size.height)
            
            //開畫布
            UIGraphicsBeginImageContext(qrcodeRect.size)
            crCodeImage.draw(in: qrcodeRect)
            let iconSize = CGSize(width:qrcodeRect.size.width * 0.25,height:qrcodeRect.size.height * 0.25)
            let x = (qrcodeRect.width - iconSize.width) * 0.5
            let y = (qrcodeRect.height - iconSize.height) * 0.5
            iconImage.draw(in: CGRect(x:x, y:y, width:iconSize.width,height:iconSize.height))
            //關畫布
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            return resultImage
        }
        return crCodeImage
    }
    
    func setQrcodeColor(qrCode: CIImage) -> CIFilter{
        let colorFilter = CIFilter(name: "CIFalseColor")!
        colorFilter.setDefaults()
        colorFilter.setValue(qrCode, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        return colorFilter
    }
}

