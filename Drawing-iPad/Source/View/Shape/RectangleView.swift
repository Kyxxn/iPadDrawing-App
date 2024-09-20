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
    var isSelected: Bool = false {
        didSet {
            updateSelectionState()
        }
    }
    
    init(rectangleID: UUID) {
        self.rectangleID = rectangleID
        super.init(frame: .zero)
        setupConfiguration()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateSelectionState() {
        if isSelected {
            self.layer.borderWidth = 5.0
            self.layer.borderColor = UIColor.black.cgColor
        } else {
            self.layer.borderWidth = 0.0
            self.layer.borderColor = nil
        }
    }
    
    private func setupConfiguration() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRectangleTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleRectangleTapped() {
        print("RectangleView - handleRectangleTapped")
        delegate?.didTapRectangleGesture(self)
    }
    
    func setupFromModel(shape: BaseShape) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame.origin = shape.origin.toCGPoint
        self.frame.size = shape.size.toCGSize
        if let shape = shape as? Rectangle {
            self.backgroundColor = UIColor(
                red: CGFloat(shape.color.red) / 255.0,
                green: CGFloat(shape.color.green) / 255.0,
                blue: CGFloat(shape.color.blue) / 255.0,
                alpha: shape.alpha.toCGFloat
            )
        }
    }
}
