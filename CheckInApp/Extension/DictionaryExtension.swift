//
//  DictionaryExtension.swift
//  PropzySam
//
//  Created by Doan Van Phuong on 10/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

extension Dictionary {
    func toJSONString() -> String? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        if let JSONString = String(data: jsonData!, encoding: String.Encoding.utf8) {
            return JSONString
        }
        return nil
    }
}
