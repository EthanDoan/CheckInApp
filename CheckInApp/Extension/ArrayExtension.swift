//
//  ArrayExtension.swift
//  PropzySam
//
//  Created by Doan Van Phuong on 10/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

extension Array {
    func toJSONString() -> String? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        if let JSONString = String(data: jsonData!, encoding: String.Encoding.utf8) {
            return JSONString
        }
        return nil
    }
    func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
}
