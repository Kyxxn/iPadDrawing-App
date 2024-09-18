//
//  Alpha.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

enum Alpha: Int, CaseIterable {
    case one = 1, two, three, four, five, six, seven, eight, nine, ten
    
}

extension Alpha: CustomStringConvertible {
    var description: String {
        String(self.rawValue)
    }
    
    var toFloat: Float {
        Float(self.rawValue) / 10
    }
    
    var toCGFloat: CGFloat {
        CGFloat(self.rawValue) / 10
    }
}
