//
//  RectangleFactory.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import Foundation

struct RectangleFactory {
    let planeSize: CGSize
    
    init(planeSize: CGSize) {
        self.planeSize = planeSize
    }
    
    func makeRectangle() -> Rectangle {
        return Rectangle(
            origin: RandomFactory.makeRandomOrigin(size: planeSize),
            size: RandomFactory.makeRandomSize(),
            color: RandomFactory.makeRandomColor(),
            alpha: RandomFactory.makeRandomAlpha()
        )
    }
}
