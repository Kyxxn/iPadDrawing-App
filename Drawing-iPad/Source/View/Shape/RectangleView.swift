//
//  RectangleView.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/17/24.
//

import UIKit

protocol RectangleTapGestureDelegate: AnyObject {
    func didTapRectangleGesture(_ rectangleView: RectangleView)
}

final class RectangleView: UIView {
    weak var delegate: RectangleTapGestureDelegate?
    let rectangleID: UUID
    
    init() {
    init(rectangleID: UUID) {
        self.rectangleID = rectangleID
        super.init(frame: .zero)
        setupConfiguration()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConfiguration() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRectangleTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleRectangleTapped() {
        print("RectangleView - handleRectangleTapped")
        delegate?.didTapRectangleGesture(self)
    }
    
    func setupFromModel(rectangle: Rectangle) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame.origin = rectangle.origin.toCGPoint
        self.frame.size = rectangle.size.toCGSize
        self.backgroundColor = UIColor(
            red: CGFloat(rectangle.color.red) / 255.0,
            green: CGFloat(rectangle.color.green) / 255.0,
            blue: CGFloat(rectangle.color.blue) / 255.0,
            alpha: rectangle.alpha.toCGFloat
        )
    }
}
