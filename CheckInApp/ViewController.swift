//
//  ViewController.swift
//  CheckInApp
//
//  Created by Doan Van Phuong on 12/30/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let scanBarBtn = UIBarButtonItem(title: "SCAN", style: .plain, target: self, action: #selector(scanQRcode(_:)))
        self.navigationItem.leftBarButtonItem  = scanBarBtn
        
    }
    
    @IBAction func scanQRcode(_ sender: UIBarButtonItem) {
        print("scanQRcode")
    }


}

