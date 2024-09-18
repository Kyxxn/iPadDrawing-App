//
//  Point.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

struct Point: Equatable {
    private var x: Double
    private var y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        "X: \(String(format: "%.2f", self.x)), Y: \(String(format: "%.2f", self.y))"
    }
    
    var toCGPoint: CGPoint {
        CGPoint(x: self.x, y: self.y)
    }
}
