//
//  PhotoFactory.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/20/24.
//

import Foundation

struct PhotoFactory: ShapeCreatable {
    let planeSize: CGSize
    
    init(viewBoundsSize: CGSize) {
        self.planeSize = viewBoundsSize
    }
    
    func makeShape() -> Photo {
        self.makeShape(imageURL: URL(string: "TempURL")!)
        // 현재는 사용되지 않음
    }
    
    func makeShape(imageURL: URL) -> Photo {
        return Photo(
            origin: RandomFactory.makeRandomOrigin(size: planeSize),
            size: RandomFactory.makeRandomSize(),
            alpha: RandomFactory.makeRandomAlpha(),
            imageURL: imageURL
        )
    }
}
