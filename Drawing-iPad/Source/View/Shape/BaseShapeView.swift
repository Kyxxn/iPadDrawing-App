//
//  BaseShapeView.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/21/24.
//

import UIKit

protocol ShapeViewDelegate: AnyObject {
    func didTapShapeView(_ shapeView: BaseShapeView)
}

class BaseShapeView: UIView {
    weak var delegate: ShapeViewDelegate?
    let shapeID: UUID
    var isSelected: Bool = false {
        didSet {
            updateSelectionState()
        }
    }
    
    init(shapeID: UUID) {
        self.shapeID = shapeID
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleShapeTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleShapeTapped() {
        print("BaseShapeView - handleShapeTapped")
        delegate?.didTapShapeView(self)
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
