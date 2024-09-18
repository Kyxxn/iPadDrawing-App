//
//  Color.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

/// UInt8로 하여 0~255를 컴파일 시점에서 제어함
struct Color {
    private(set) var red: UInt8
    private(set) var green: UInt8
    private(set) var blue: UInt8
    
    init(red: UInt8, green: UInt8, blue: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

extension Color: CustomStringConvertible {
    var description: String {
        return "R: \(self.red), G: \(self.green), B: \(self.blue)"
    }
    
    var toHexCode: String {
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}
