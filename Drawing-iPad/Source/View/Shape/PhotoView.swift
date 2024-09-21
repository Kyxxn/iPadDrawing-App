//
//  PhotoView.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/21/24.
//

import UIKit

final class PhotoView: BaseShapeView {
    private let imageView: UIImageView?
    
    init(imageView: UIImageView?, shapeID: UUID) {
        self.imageView = imageView
        super.init(shapeID: shapeID)
        setupConfiguration()
    }
    
    private func setupConfiguration() {
        guard let imageView = imageView else { return }
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
