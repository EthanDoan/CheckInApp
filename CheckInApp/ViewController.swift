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
    
    var listView: ListView!

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
        
        FirebaseApi.getList { (list) in
            if let results = list {
                self.listView = ListView(data: results)
                self.view.addSubview(self.listView)
                self.listView.snp.makeConstraints { (make) in
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                    make.left.equalTo(self.view.snp.left)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                    make.right.equalTo(self.view.snp.right)
                }
            }
        }
    }
    
    
    @IBAction func scanQRcode(_ sender: UIBarButtonItem) {
        guard checkScanPermissions() else { return }
        readerVC.modalPresentationStyle = .fullScreen
        readerVC.delegate               = self
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
          if let result = result {
            let array = result.value.components(separatedBy: "-")
            let obj = self.mapArrayToObject(components: array)
            FirebaseApi.update(value: obj.1, forKey: obj.0)
          }
        }

        present(readerVC, animated: true, completion: nil)
        
    }
    
    
}

extension ViewController {
    func mapArrayToObject(components: [String]) -> (String,[String:Any]) {
        var object = [String:Any]()

        let slice = components.suffix(from: 2)
        let infoText = slice.joined(separator: " - ")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let dateString = dateFormatter.string(from: Date())
        
        object.updateValue(components[0], forKey: "username")
        object.updateValue(components[1], forKey: "id")
        object.updateValue(infoText, forKey: "info")
        object.updateValue(dateString, forKey: "checkintime")
        return (components[1], object)
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

