//
//  Rectangle.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

final class Rectangle {
    
    private let identifier = UUID()
    private var origin: Point
    private var size: Size
    private var color: Color
    private var alpha: Alpha
    
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
    
    func originValue() -> Point {
        return self.origin
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        "[\(self.identifier)]\n: \(origin), \(size), \(color), \(alpha)\n"
    }
}
