//
//  QRcodeManager.swift
//  Qrcode
//
//  Created by YJ Huang on 2019/6/12.
//  Copyright © 2019 YJ Huang. All rights reserved.
//

import UIKit

class QRcodeManager: NSObject {
    
    func showQRcode(dataString : String ,displayView : UIView) -> UIImage? {
        
        let  data = dataString.data(using: .utf8, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        
        if let qrCodeImge = filter?.outputImage {
            //            let colorFilter = self.setQrcodeColor(qrCode: qrCodeImge)
            //            let colorFulImage = colorFilter.outputImage
            
            let scaleX = displayView.frame.size.width / qrCodeImge.extent.size.width
            let scaleY = displayView.frame.size.height / qrCodeImge.extent.size.height
            let transForm = CGAffineTransform(scaleX: scaleX, y: scaleY)
            let transformedImage = qrCodeImge.transformed(by: transForm)
            
            return UIImage(ciImage: transformedImage)
        }
        return nil
    }
    
    func showQRcode(dataString : String, displayView : UIView , icon: UIImage ,widthScale: CGFloat) -> UIImage? {
        if let qrCode = self.showQRcode(dataString: dataString, displayView: displayView) {
            if let qrCodeWithIcon = self.drawIconIn(QRcode: qrCode, icon: icon, scale: widthScale) {
                return qrCodeWithIcon
            }
        }
        return nil
    }
    
    func drawIconIn(QRcode: UIImage, icon: UIImage, scale:CGFloat) -> UIImage? {
        
        let qrcodeRect = CGRect(x:0, y:0, width:icon.size.width,height:icon.size.height)
        
        UIGraphicsBeginImageContext(qrcodeRect.size)
        QRcode.draw(in: qrcodeRect)
        
        var currentScale: CGFloat?
        if(scale > 1) {
            currentScale = 1
        } else {
            currentScale = scale
        }
        
        if let currentScale = currentScale {
            let iconSize = CGSize(width:qrcodeRect.size.width * currentScale,height:qrcodeRect.size.height * currentScale)
            let iconX = (qrcodeRect.width - iconSize.width) * 0.5
            let iconY = (qrcodeRect.height - iconSize.height) * 0.5
            icon.draw(in: CGRect(x:iconX, y:iconY, width:iconSize.width,height:iconSize.height))
            let resulQRcode = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return resulQRcode
        }
        return nil
    }
}
