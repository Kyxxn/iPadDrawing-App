//
//  Photo.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/20/24.
//

import Foundation

final class Photo: BaseShape {
    private var imageURL: URL
    override var description: String {
        return super.description + "Image URL: \(imageURL)\n"
    }
    
    init(
        origin: Point,
        size: Size,
        alpha: Alpha,
        imageURL: URL
    ) {
        self.imageURL = imageURL
        super.init(
            origin: origin,
            size: size,
            alpha: alpha
        )
    }
}
