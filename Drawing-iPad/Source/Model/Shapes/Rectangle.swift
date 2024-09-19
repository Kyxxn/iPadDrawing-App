//
//  Rectangle.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

final class Rectangle {
    let identifier = UUID()
    private(set) var origin: Point {
        didSet {
            postRectangleUpdated()
        }
    }
    private(set) var size: Size {
        didSet {
            postRectangleUpdated()
        }
    }
    private(set) var color: Color {
        didSet {
            postRectangleUpdated()
        }
    }
    private(set) var alpha: Alpha {
        didSet {
            postRectangleUpdated()
        }
    }
    
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
    
    private func postRectangleUpdated() {
        print("postRectangleUpdated")
        NotificationCenter.default.post(name: .rectangleUpdated, object: nil)
    }
    
    func updateColor(color: Color) {
        self.color = color
    }
    
    func updateAlpha(alpha: Alpha) {
        self.alpha = alpha
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        "[\(self.identifier)]\n: \(origin), \(size), \(color), \(alpha)\n"
    }
}
