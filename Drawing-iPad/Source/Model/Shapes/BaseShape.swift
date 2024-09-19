//
//  BaseShape.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/20/24.
//

import Foundation

class BaseShape: Shapable, AlphaControllable, CustomStringConvertible  {
    let identifier = UUID()
    private(set) var origin: Point {
        didSet {
            postShapeUpdated()
        }
    }
    private(set) var size: Size {
        didSet {
            postShapeUpdated()
        }
    }
    private(set) var alpha: Alpha {
        didSet {
            postShapeUpdated()
        }
    }
    var description: String {
        "[\(self.identifier)]\n: \(origin), \(size), \(alpha)\n"
    }
    
    init(origin: Point, size: Size, alpha: Alpha) {
        self.origin = origin
        self.size = size
        self.alpha = alpha
    }
    
    func postShapeUpdated() {
        print("postShapeUpdated")
        NotificationCenter.default.post(name: .shapeUpdated, object: self)
    }
    
    func updateAlpha(alpha: Alpha) {
        self.alpha = alpha
    }
}
