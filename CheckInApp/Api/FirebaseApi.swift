//
//  FirebaseApi.swift
//  CheckInApp
//
//  Created by Doan Van Phuong on 12/30/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Firebase

class FirebaseApi: NSObject {
    class func update(value: [String:Any],forKey key:String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
//        ref.child("users/\(key)").setValue(value)
        ref.child("users/\(key)").setValue(value) { (error, ref) in
            if (error != nil) {
                return
            }
            DispatchQueue.main.async {
                PHAlert.showSuccessAlert("add new employee success")
            }
        }
    }
}
