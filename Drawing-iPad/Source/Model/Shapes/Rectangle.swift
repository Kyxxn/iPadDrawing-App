//
//  Rectangle.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

final class Rectangle {
    
    private let identifier = UUID()
    private(set) var origin: Point
    private(set) var size: Size
    private(set) var color: Color
    private(set) var alpha: Alpha
    
    init(
        origin: Point,
        size: Size,
        color: Color,
        alpha: Alpha
    ) {
        self.origin = origin
        self.size = size
        self.color = color
        self.alpha = alpha
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        "[\(self.identifier)]\n: \(origin), \(size), \(color), \(alpha)\n"
    }
}
