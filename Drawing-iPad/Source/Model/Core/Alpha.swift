//
//  Alpha.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

enum Alpha: Int, CaseIterable {
    case one = 1, two, three, four, five, six, seven, eight, nine, ten
    
    static func from(floatValue: Float) -> Alpha? {
        let scaledValue = floatValue * 10
        let rawValue = max(1, min(10, Int(round(scaledValue))))
        return Alpha(rawValue: rawValue)
    }
}

extension Alpha: CustomStringConvertible {
    var description: String {
        String(self.rawValue)
    }
    
    var toFloat: Float {
        Float(self.rawValue)
    }
    
    var toCGFloat: CGFloat {
        CGFloat(self.rawValue) / 10
    }
}
