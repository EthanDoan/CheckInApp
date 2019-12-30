//
//  UIFontExtension.swift
//  UITabBarControllerProgrammatically
//
//  Created by Doan Van Phuong on 10/29/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    enum HelveticaNeueType: String {
        case Base = ""
        case Bold = "-Bold"
        case Italic = "-Italic"
        case UltraLight = "-UltraLight"
        case CondensedBlack = "-CondensedBlack"
        case BoldItalic = "-BoldItalic"
        case CondensedBold = "-CondensedBold"
        case Medium = "-Medium"
        case Light = "-Light"
        case Thin = "-Thin"
        case ThinItalic = "-ThinItalic"
        case LightItalic = "-LightItalic"
        case UltraLightItalic = "-UltraLightItalic"
        case MediumItalic = "-MediumItalic"
    }
    
    static func fHelveticaNeue(size: Float!) -> UIFont! {
        return UIFont(name: "HelveticaNeue", size: CGFloat(size))
    }
    
    static func fHelveticaNeue(size: Float!, type: HelveticaNeueType) -> UIFont! {
        return UIFont(name: "HelveticaNeue\(type.rawValue)", size: CGFloat(size))
    }
    
}
