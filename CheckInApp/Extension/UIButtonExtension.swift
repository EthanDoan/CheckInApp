//
//  UIButtonExtension.swift
//  UITabBarControllerProgrammatically
//
//  Created by Doan Van Phuong on 10/31/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    private struct CustomButtonProperties {
        static var actionTap: String = "buttonTapCallback"
    }
    
    var buttonTapCallback: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &CustomButtonProperties.actionTap) as? () -> Void
        }
        set {
            if let unwrappedValue = newValue {
                objc_setAssociatedObject(self, &CustomButtonProperties.actionTap, unwrappedValue as (() -> Void)?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    static func createButton(image: UIImage, frame: CGRect, tapCallback: @escaping () -> Void) -> UIButton {
        let button = UIButton(frame: frame)
        button.setImage(image, for: .normal)
        button.buttonTapCallback = tapCallback
        button.addTarget(self, action: #selector(UIButton.buttonTapAction(_ :)), for: .touchUpInside)
        return button
    }
    
    @objc static func buttonTapAction(_ sender: UIButton) {
        if let btnCallback = sender.buttonTapCallback {
            btnCallback()
        } else {
            print("btn tap callback is nil")
        }
    }
}

