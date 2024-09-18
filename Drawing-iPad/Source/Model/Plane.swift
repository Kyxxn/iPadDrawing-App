//
//  Plane.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

// TODO: struct로 만들 경우 mutating을 붙여야 함, struct 안에 class가 있는 구조의 문제는 없나 ?
final class Plane {
    private var rectangles: [Rectangle]
    var count: Int { self.rectangles.count }
    
    init(rectangles: [Rectangle]) {
        self.rectangles = rectangles
    }
    
    convenience init() {
        self.init(rectangles: [])
    }
    
    func appendRectangle(rectangle: Rectangle) {
        self.rectangles.append(rectangle)
    }
    
    func containsRectangle(at origin: Point) -> Bool {
        self.rectangles.contains {
            $0.origin == origin
        }
    }
    
    func rectangle(withID identifier: UUID) -> Rectangle? {
        return rectangles.first { $0.identifier == identifier }
    }
}

// MARK: - Subscript 구현

extension Plane {
    subscript(index: Int) -> Rectangle? {
        guard index >= 0 && index < rectangles.count else { return nil }
        return rectangles[index]
    }
}
