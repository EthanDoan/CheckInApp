//
//  CGRectExtension.swift
//  UITabBarControllerProgrammatically
//
//  Created by Doan Van Phuong on 11/4/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    
    func debugPrint() {
        print("""
            x: \(origin.x)
            y: \(origin.y)
            w: \(size.width)
            h: \(size.height)
            """)
    }
}
