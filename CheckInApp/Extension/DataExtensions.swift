//
//  DataExtensions.swift
//  PropzySam
//
//  Created by Doan Van Phuong on 9/27/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

extension Data {
    
    func convertToDictionary() -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
