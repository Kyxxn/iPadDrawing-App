//
//  Point.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

struct Point {
    private var x: Double
    private var y: Double
}

extension Point: CustomStringConvertible {
    var description: String {
        "X: \(self.x), Y: \(self.y)"
    }
}
