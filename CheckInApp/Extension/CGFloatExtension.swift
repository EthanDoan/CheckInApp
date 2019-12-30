//
//  CGFloatExtension.swift
//  UITabBarControllerProgrammatically
//
//  Created by Doan Van Phuong on 11/18/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
