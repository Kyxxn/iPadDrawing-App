//
//  Rectangle.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

final class Rectangle: BaseShape, Colorable {
    private(set) var color: Color {
        didSet {
            postShapeUpdated()
        }
    }
    
    init(
        origin: Point,
        size: Size,
        color: Color,
        alpha: Alpha
    ) {
        self.color = color
        super.init(
            origin: origin,
            size: size,
            alpha: alpha
        )
    }
    
    func updateColor(color: Color) {
        self.color = color
    }
}

