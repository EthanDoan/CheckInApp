//
//  PHUINavigationBarExtensions.swift
//  PropzySam
//
//  Created by Doan Van Phuong on 8/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    func setTransparentBackground(isTransparent: Bool) {
        if isTransparent == true {
            setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            shadowImage = UIImage()
            isTranslucent = true
        } else {
            setBackgroundImage(nil, for: UIBarMetrics.default)
//            shadowImage = UIImage()
//            isTranslucent = false
        }
        
    }
    
    func setBackButtonImage(image: UIImage) {
        let aimage = image.withRenderingMode(.alwaysOriginal)
        tintColor = UIColor.clear
        backIndicatorImage = aimage
        backIndicatorTransitionMaskImage = aimage
    }
    
    func makeNavStyleOrange() {
        // -- Config NavigationBar Background --
        //self.setBackgroundImage(UIImage(color: UIColor.PROPZY_OGRANGE, size: CGSize(width: 1, height: 1)), for: .default)
        self.barTintColor = .APP_OGRANGE
        self.isTranslucent = false
        // -- Config NavigationBar Title Font --
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.fHelveticaNeue(size: 16.0, type: UIFont.HelveticaNeueType.Medium)!,
            .foregroundColor: UIColor.white]
        self.titleTextAttributes = titleAttributes
        self.tintColor = UIColor.white
    }
    
}
