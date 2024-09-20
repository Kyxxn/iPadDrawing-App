//
//  RandomFactory.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

enum RandomFactory {
    static func makeRandomOrigin(size: CGSize) -> Point {
        let maxX = size.width - 150
        let maxY = size.height - 150
        
        return Point(
            x: Double.random(in: 0...maxX),
            y: Double.random(in: 0...maxY)
        )
    }
    
    static func makeRandomSize() -> Size {
        return Size(
            width: Double.random(in: 100...150),
            height: Double.random(in: 100...150)
        )
    }
    
    static func makeRandomColor() -> Color {
        return Color(
            red: UInt8.random(in: 0...255),
            green: UInt8.random(in: 0...255),
            blue: UInt8.random(in: 0...255)
        )
    }
    
    static func makeRandomAlpha() -> Alpha {
        return Alpha.allCases.randomElement() ?? .five
    }
}
