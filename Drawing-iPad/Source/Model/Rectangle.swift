//
//  Rectangle.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

final class Rectangle {
    private let identifier: String
    private var origin: Point
    private var size: Size
    private var color: Color
    private var alpha: Alpha
    
    init(
        identifier: String,
        origin: Point,
        size: Size,
        color: Color,
        alpha: Alpha
    ) {
        self.identifier = identifier
        self.origin = origin
        self.size = size
        self.color = color
        self.alpha = alpha
    }
}
