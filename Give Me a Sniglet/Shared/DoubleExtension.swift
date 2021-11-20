//
//  DoubleExtension.swift
//  Give Me a Sniglet
//
//  Created by Marquis Kurt on 16/11/21.
//

import Foundation

extension Double {
    func asPercentage() -> Int {
        var new = self
        if new < 100 { new *= 100 }
        return Int(new.rounded())
    }
}
