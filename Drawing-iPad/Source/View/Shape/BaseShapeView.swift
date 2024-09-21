//
//  BaseShapeView.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/21/24.
//

import UIKit

protocol ShapeViewDelegate: AnyObject {
    func didTapShapeView(_ shapeView: BaseShapeView)
    func didPanShapeView(_ shapeView: BaseShapeView, sender: UIPanGestureRecognizer)
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
        setupGestures()
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
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleShapeTap))
        self.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleShapePan))
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func handleShapeTap() {
        print("BaseShapeView - handleShapeTapped")
        delegate?.didTapShapeView(self)
    }
    
    @objc private func handleShapePan(sender: UIPanGestureRecognizer) {
        print("BaseShapeView - handleShapePan")
        delegate?.didPanShapeView(self, sender: sender)
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
    
    func updateFrame(origin: Point, size: Size) {
        print("\(origin), \(size)")

        // origin은 부모한테 걸려있어서 안 뜨는 거 같음, 따로 설정
        if let superview = self.superview {
            if let leadingConstraint = findConstraint(in: superview, attribute: .leading) {
                leadingConstraint.constant = origin.xValue()
            }

            if let topConstraint = findConstraint(in: superview, attribute: .top) {
                topConstraint.constant = origin.yValue()
            }
        }

        if let widthConstraint = findConstraint(attribute: .width) {
            widthConstraint.constant = size.widthValue()
        }

        if let heightConstraint = findConstraint(attribute: .height) {
            heightConstraint.constant = size.heightValue()
        }
    }
    
    // 부모 or 나한테 걸려있는 제약 찾기
    func findConstraint(in view: UIView? = nil, attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        let targetView = view ?? self
        return targetView.constraints.first {
            ($0.firstItem as? UIView) == self && $0.firstAttribute == attribute
        }
    }
}
