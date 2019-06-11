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
        
        //show QRcode without icon
//        if let resultQrcode = QRcodeManager().showQRcode(dataString: inputUrl, displayView: self.qrCodeResult) {
//            self.qrCodeResult.image = resultQrcode;
//        }
        
        //show QRcode with icon
        let iconImg = UIImage(named: "hk.jpg")
        if let resultQrcode = QRcodeManager().showQRcode(dataString: inputUrl, displayView: self.qrCodeResult, icon: iconImg!, widthScale: 0.3) {
            self.qrCodeResult.image = resultQrcode
        }
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

