//
//  DateExtensions.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

extension Date {
    func toMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    func toMillisString() -> String {
        return String(toMillis())
    }
}
