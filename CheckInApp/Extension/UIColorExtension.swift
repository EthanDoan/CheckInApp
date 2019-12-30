//
//  UIColorExtension.swift
//  UITabBarControllerProgrammatically
//
//  Created by Doan Van Phuong on 10/29/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

//app color
extension UIColor {
    static let APP_OGRANGE = UIColor.init(241, 116, 35)
    static let APP_GRAY_BUTTON_COLOR = UIColor.init(95, 95, 95, 0.5)
    static let APP_TEXT_COLOR = UIColor.init(95, 95, 95)
}


extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }

    public convenience init(_ r: UInt,_ g: UInt,_ b: UInt,_ alpha: CGFloat = 1.0 ) {
        self.init(
            red:   CGFloat(r)/255.0,
            green: CGFloat(g)/255.0,
            blue:  CGFloat(b)/255.0,
            alpha: alpha
        )
    }
    
    public typealias RGBA = (r: UInt, g: UInt, b: UInt, a: UInt)
    public convenience init(rgba: RGBA) {
        self.init(
            rgb: (rgba.r, rgba.g, rgba.b),
            alpha: CGFloat(rgba.a)/255.0
        )
    }
    
    public typealias RGB = (r: UInt, g: UInt, b: UInt)
    public convenience init(rgb: RGB, alpha: CGFloat = 1.0) {
        self.init(
            red:   CGFloat(rgb.r)/255.0,
            green: CGFloat(rgb.g)/255.0,
            blue:  CGFloat(rgb.b)/255.0,
            alpha: alpha
        )
    }
    
    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     - parameter hex6: Six-digit hexadecimal value.
     */
    public convenience init(hex6: UInt32, alpha: CGFloat = 1)
    {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public class func randomColor() -> UIColor {
        let component = { CGFloat(drand48()) }
        return UIColor(red: component(), green: component(), blue: component(), alpha: 1.0)
    }
    
    /**
     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.
     - parameter rgba: String value.
     */
    public convenience init(hexString: String, alpha: CGFloat = 1)
    {
        guard hexString.hasPrefix("#") else {
            fatalError("UIColor error => \(hexString)")
        }
        
        let hexStr: String = String(hexString[String.Index.init(encodedOffset: 1)...])
        var hexValue:  UInt32 = 0
        
        guard Scanner(string: hexStr).scanHexInt32(&hexValue) else {
            fatalError("UIColor error => unable To Scan Hex Value \(hexStr)")
        }
        
        if (hexStr.count != 6) {
            fatalError("UIColor error => unable To Scan Hex Value \(hexStr)")
        }
        
        self.init(hex6: hexValue, alpha: alpha)
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
