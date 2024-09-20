//
//  Plane.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

// TODO: struct로 만들 경우 mutating을 붙여야 함, struct 안에 class가 있는 구조의 문제는 없나 ?
final class Plane {
    private var shapes: [BaseShape] {
        didSet {
            postPlaneChangedNotification()
        }
    }
    var count: Int { self.shapes.count }
    
    init(shapes: [BaseShape]) {
        self.shapes = shapes
    }
    
    convenience init() {
        self.init(shapes: [])
    }
    
    private func postPlaneChangedNotification() {
        print("postPlaneChangedNotification")
        NotificationCenter.default.post(name: .planeUpdated, object: nil)
    }
    
    func appendShape(shape: BaseShape) {
        self.shapes.append(shape)
    }
    
    func containsRectangle(at origin: Point) -> Bool {
        self.shapes.contains {
            $0.origin == origin
        }
    }
    
    func findShape(withID identifier: UUID) -> BaseShape? {
        return shapes.first { $0.identifier == identifier }
    }
}

// MARK: - Subscript 구현

extension Plane {
    subscript(index: Int) -> BaseShape? {
        guard index >= 0 && index < shapes.count else { return nil }
        return shapes[index]
    }
}
