//
//  ViewController.swift
//  CheckInApp
//
//  Created by Doan Van Phuong on 12/30/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import QRCodeReader
import Firebase

class ViewController: UIViewController {

    lazy var reader: QRCodeReader = QRCodeReader()
    lazy var readerVC: QRCodeReaderViewController = {
      let builder = QRCodeReaderViewControllerBuilder {
        $0.reader                  = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        $0.showTorchButton         = true
        $0.preferredStatusBarStyle = .lightContent
        $0.showOverlayView         = true
        $0.rectOfInterest          = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        
        $0.reader.stopScanningWhenCodeIsFound = false
      }
      
      return QRCodeReaderViewController(builder: builder)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let scanBarBtn = UIBarButtonItem(title: "SCAN", style: .plain, target: self, action: #selector(scanQRcode(_:)))
        self.navigationItem.leftBarButtonItem  = scanBarBtn
    }
    
    
    @IBAction func scanQRcode(_ sender: UIBarButtonItem) {
        guard checkScanPermissions() else { return }
        readerVC.modalPresentationStyle = .fullScreen
        readerVC.delegate               = self
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
          if let result = result {
            let array = result.value.components(separatedBy: "-")
            print("\(array)")
            let obj = self.mapArrayToObject(components: array)
            FirebaseApi.update(value: obj.1, forKey: obj.0)
          }
        }

        present(readerVC, animated: true, completion: nil)
        
    }
    
    
}

extension ViewController {
    func mapArrayToObject(components: [String]) -> (String,[String:Any]) {
        let key = components[1]
        
        var object = [String:Any]()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let dateString = dateFormatter.string(from: Date())
        
        object.updateValue(components[0], forKey: "username")
        object.updateValue(components[1], forKey: "id")
        object.updateValue(components[2], forKey: "info")
        object.updateValue(dateString, forKey: "checkintime")
        return (key, object)
    }
    
    private func checkScanPermissions() -> Bool {
      do {
        return try QRCodeReader.supportsMetadataObjectTypes()
      } catch let error as NSError {
        let alert: UIAlertController

        switch error.code {
        case -11852:
          alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)

          alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
            DispatchQueue.main.async {
              if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(settingsURL)
              }
            }
          }))

          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        default:
          alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }
        present(alert, animated: true, completion: nil)
        return false
      }
    }
}

extension ViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: true) {
            
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
    
}

