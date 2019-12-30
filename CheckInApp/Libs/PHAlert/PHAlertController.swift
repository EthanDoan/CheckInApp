//
//  PHAlert.swift
//  PropzySam
//
//  Created by MyVTD on 10/8/18.
//  Copyright © 2018 Admin. All rights reserved.
//


/*
 Example:
 
 ------------------------------------------
 // Alert success bình thường: (1 nút)
 PHAlert.showSuccessAlert("Success")
 
 // Alert warning bình thường: (1 nút)
 PHAlert.showWarningAlert("Warning")
 
 // Alert error bình thường: (1 nút)
 PHAlert.showErrorAlert("Error")
 
 // Alert custom hình ảnh bình thường: (1 nút)
 PHAlert.showCustomImageAlert("Custom image", imageFile: "img_file_name")
 
 ------------------------------------------
 // (2 nút)
 PHAlert.showAlert(message: "Two buttons", style: .warning, cancelTitle: "Đóng", otherTitle: "OK", cancelAction: {
 // cancel clicked action
 print("Cancel")
 }) {
 // other button clicked action
 print("OK")
 }
 
 // Tương tự cho alert normal (2 nút, ko có hình)
 PHAlert.showNormalAlert("Title two buttons", message: "Message two buttons", cancelTitle: "Đóng", otherTitle: "OK", cancelAction: {
 // cancel clicked action
 print("Cancel")
 }) {
 // other button clicked action
 print("OK")
 }
 
 ------------------------------------------
 // Trong PHAlert.showAlert() và PHAlert.showNormalAlert() các tham số otherTitle, cancelAction, otherAction có thể không truyền (mặc định nil)
 // Tham số cancelTitle nếu không truyền sẽ mặc định là "Đóng"
 // otherTitle nếu truyền sẽ ra 2 button, không truyền ra 1 button
 
 */

import UIKit

let PHAlert = PHAlertController.shared

typealias PHOtherAction = (() -> Void)
typealias PHCancelAction = (() -> Void)

public enum PHAlertStyle {
    case success, error, warning
    case customImage(imageFile:String)
}

class PHAlertController: NSObject {
    
    class var shared: PHAlertController {
        struct Singleton {
            static let instance = PHAlertController()
        }
        return Singleton.instance
    }
    
    func showSuccessAlert(_ message: String, cancelAction: PHCancelAction? = nil) {
        self.showAlert(message: message, style: .success, cancelAction: cancelAction)
    }
    
    func showWarningAlert(_ message: String, cancelAction: PHCancelAction? = nil) {
        self.showAlert(message: message, style: .warning, cancelAction: cancelAction)
    }
    
    func showErrorAlert(_ message: String, cancelAction: PHCancelAction? = nil) {
        self.showAlert(message: message, style: .error, cancelAction: cancelAction)
    }
    
    func showCustomImageAlert(_ message: String, imageFile: String, cancelAction: PHCancelAction? = nil) {
        self.showAlert(message: message, style: .customImage(imageFile: imageFile), cancelAction: cancelAction)
    }
    
    func showNormalAlert(_ title: String, message: String? = nil, cancelTitle: String = "Đóng", otherTitle:
        String? = nil, cancelAction: PHCancelAction? = nil, otherAction: PHOtherAction? = nil) {
        var buttonColor: UIColor = .APP_GRAY_BUTTON_COLOR
        if otherTitle == nil { // 1 button
            buttonColor = .APP_OGRANGE
        }
        _ = SweetAlert().showAlert(title, subTitle: message, titleFontSize: 24, subTitleFontSize: 16, style: .none, buttonTitle: cancelTitle, buttonColor: buttonColor, otherButtonTitle: otherTitle, otherButtonColor: .APP_OGRANGE, action: { (isOtherButton) in
            if isOtherButton {
                guard otherAction != nil else {return}
                otherAction!()
            } else {
                guard cancelAction != nil else {return}
                cancelAction!()
            }
        })
    }
    
    //use this function when need to custom style for some of characters in message
    func showNormalAlert(_ title: String, message: NSAttributedString? = nil, cancelTitle: String = "Đóng", otherTitle:
        String? = nil, cancelAction: PHCancelAction? = nil, otherAction: PHOtherAction? = nil) {
        var buttonColor: UIColor = .APP_GRAY_BUTTON_COLOR
        if otherTitle == nil { // 1 button
            buttonColor = .APP_OGRANGE
        }
        _ = SweetAlert().showAlert(title, subTitle: message, titleFontSize: 24, subTitleFontSize: 16, style: .none, buttonTitle: cancelTitle, buttonColor: buttonColor, otherButtonTitle: otherTitle, otherButtonColor: .APP_OGRANGE, action: { (isOtherButton) in
            if isOtherButton {
                guard otherAction != nil else {return}
                otherAction!()
            } else {
                guard cancelAction != nil else {return}
                cancelAction!()
            }
        })
    }
    
    func showAlert(message: String? = nil, style: PHAlertStyle, cancelTitle: String = "Đóng", otherTitle:
        String? = nil, cancelAction: PHCancelAction? = nil, otherAction: PHOtherAction? = nil) {
        var imgSource: String = "ic_alert_done"
        switch style {
        case .success:
            imgSource = "ic_alert_done"
        case .warning:
            imgSource = "ic_alert_warning"
        case .error:
            imgSource = "ic_alert_error"
        case let .customImage(imageFile: imageFile):
            imgSource = imageFile
        }
        var buttonColor: UIColor = .APP_GRAY_BUTTON_COLOR
        if otherTitle == nil { // 1 button
            buttonColor = .APP_OGRANGE
        }
        _ = SweetAlert().showAlert("", subTitle: message, style: .customImage(imageFile: imgSource), buttonTitle: cancelTitle, buttonColor: buttonColor, otherButtonTitle: otherTitle, otherButtonColor: .APP_OGRANGE, action: { (isOtherButton) in
            if isOtherButton {
                guard otherAction != nil else {return}
                otherAction!()
            } else {
                guard cancelAction != nil else {return}
                cancelAction!()
            }
        })
    }
}
