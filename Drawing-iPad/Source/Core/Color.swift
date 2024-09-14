//
//  Color.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

/// UInt8로 하여 0~255를 컴파일 시점에서 제어함
struct Color {
    private var red: UInt8
    private var green: UInt8
    private var blue: UInt8
    
}

extension Color: CustomStringConvertible {
    var description: String {
        "R: \(self.red), G: \(self.green), B: \(self.blue)"
    }
}
