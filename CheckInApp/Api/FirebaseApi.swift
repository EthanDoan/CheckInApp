//
//  FirebaseApi.swift
//  CheckInApp
//
//  Created by Doan Van Phuong on 12/30/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Firebase
import AVFoundation

class FirebaseApi: NSObject {
    
    class func update(value: [String:Any],forKey key:String) {
        var updateRef: DatabaseReference!
        updateRef = Database.database().reference().child("users/\(key)")
        updateRef.observeSingleEvent(of: DataEventType.value) { (snapshot) in
            let name = value["username"] as! String
            if snapshot.exists() {
                DispatchQueue.main.async {
                    PHAlert.showErrorAlert("\(name) đã có trong danh sách!")
                }
                return
            }
            updateRef.setValue(value) { (error, ref) in
                if (error != nil) {
                    return
                }
                DispatchQueue.main.async {
                    FirebaseApi.beep()
                    PHAlert.showSuccessAlert("Welcome \(name)!")
                }
            }
        }
    }
    
    class func getList(completion: @escaping (_ list: [Employee]?)->Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("users")
        ref.observe(DataEventType.value) { (snapshot) in
            let array = snapshot.value as! [String:Any]
            let compactMap = array.compactMap({ $0.1 as? [String:String]})
            let result = compactMap.map { (dict) -> Employee in
                return Employee(userId: dict["id"]!, username: dict["username"]!, info: dict["info"]!, checkInTime: dict["checkintime"]!)
            }
            completion(result)
        }
    }
    
    class func beep() {
        let systemSoundID: SystemSoundID = 1029
//        AudioServicesPlaySystemSound (systemSoundID)
        AudioServicesPlayAlertSoundWithCompletion(systemSoundID) {
            
        }
    }
}
