//
//  Size.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

struct Size {
    private var width: Double
    private var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

extension Size: CustomStringConvertible {
    var description: String {
        "W: \(String(format: "%.2f", self.width)), H: \(String(format: "%.2f", self.height))"
    }
    
    var toCGSize: CGSize {
        CGSize(width: self.width, height: self.height)
    }
}
