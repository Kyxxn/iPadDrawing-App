//
//  Size.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

struct Size {
    private var width: Double
    private var height: Double
}

extension Size: CustomStringConvertible {
    var description: String {
        "W: \(self.width), H: \(self.height)"
    }
}
