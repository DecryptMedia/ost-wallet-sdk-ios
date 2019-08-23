/*
 Copyright © 2019 OST.com Inc
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 */

import Foundation

class OstAuthorizeDeviceQRScanner: OstBaseQRScannerViewController {
    
    class func newInstance(onSuccessScanning: ((String?) -> Void)?) -> OstAuthorizeDeviceQRScanner {
        let vc = OstAuthorizeDeviceQRScanner()
        vc.onSuccessScanning = onSuccessScanning
        return vc
    }
    
    override func configure() {
        let pageConfig = OstContent.getScanQRForAuthorizeDeviceVCConfig()
        titleLabel.updateAttributedText(data: pageConfig[OstContent.OstComponentType.titleLabel.getComponentName()],
                                        placeholders: pageConfig[OstContent.OstComponentType.placeholders.getComponentName()])
        
        super.configure()
    }
    
    override func onQRCodeDataReceived(_ data:[String]?) {
        super.onQRCodeDataReceived(data)
        
        if isValidQR() {
            let qrData = qrDataString![0]
            onSuccessScanning?(qrData)
        }else {
            showAlert(title: "Invalid QR-Code",
                      message: "QR-Code scanned for authorize device is invalid. Please scan valid QR-Code to authorize device.",
                      buttonTitle: "Scan Again",
                      cancelButtonTitle: "Cancel",
                      actionHandler: {[weak self] (alertAction) in
                        
                        self?.scannerView?.startScanning()
            }) {[weak self] (alertAction) in
                self?.onCancelScanning?()
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func isValidQR() -> Bool {
        if (nil != qrDataString)
            && (qrDataString!.count > 0 ){
            
            let qrData = qrDataString![0]
            if let payloadData = getpaylaodDataFromQR(qrData),
                let _ = try? OstAddDeviceWithQRData.getAddDeviceParamsFromQRPayload(payloadData) {
                    return true
            }
        }
        
        return false
    }
    
    override func getDataDefination() -> String {
        return OstQRCodeDataDefination.AUTHORIZE_DEVICE.rawValue
    }
}
