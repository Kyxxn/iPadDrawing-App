//
//  BaseShape.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/20/24.
//

import Foundation

class BaseShape: Shapable, AlphaControllable, CustomStringConvertible  {
    // MARK: - Properties
    
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
    
    // MARK: - Initializer
    
    init(origin: Point, size: Size, alpha: Alpha) {
        self.origin = origin
        self.size = size
        self.alpha = alpha
    }
    
    // MARK: - Method
    
    func postShapeUpdated() {
        print("postShapeUpdated")
        NotificationCenter.default.post(name: .shapeUpdated, object: self)
    }
    
    func updateAlpha(alpha: Alpha) {
        self.alpha = alpha
    }
    
    func updateOrigin(x: Double, y: Double) {
        self.origin = Point(x: x, y: y)
    }
    
    func updateSize(width: Double, height: Double) {
        self.size = Size(width: width, height: height)
    }
}
