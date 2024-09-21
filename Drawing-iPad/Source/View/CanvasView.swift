//
//  CanvasView.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import UIKit

protocol CanvasViewDelegate: AnyObject {
    func didTapShapeCreatorButtonInCanvasView(_ canvasView: CanvasView, shapeCategory: ShapeCategory)
    func didTapGestureShapeView(_ canvasView: CanvasView, shapeID: UUID)
    func didPanGestureShapeView(_ canvasView: CanvasView, shapeID: UUID, sender: UIPanGestureRecognizer)
    func didTapBackgroundColorChangeButton(_ canvasView: CanvasView)
    func didChangeAlphaSlider(_ canvasView: CanvasView, changedValue: Float)
}

final class CanvasView: UIView {
    // MARK: - Properties
    
    weak var delegate: CanvasViewDelegate?
    
    // MARK: - UI Components
    
    private let rectangleCreatorButton = ShapeCreatorButton(name: "사각형", shapeCategory: .rectangle)
    private let photoCreatorButton = ShapeCreatorButton(name: "사진", shapeCategory: .photo)
    private let creatorButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let sideView = SideView()
    private let planeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        rectangleCreatorButton.delegate = self
        photoCreatorButton.delegate = self
        sideView.delegate = self
        setupConfiguration()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func setupConfiguration() {
        self.addSubview(creatorButtonStackView)
        self.addSubview(sideView)
        self.addSubview(planeView)
        self.translatesAutoresizingMaskIntoConstraints = false
        [rectangleCreatorButton, photoCreatorButton].forEach {
            creatorButtonStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            creatorButtonStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            creatorButtonStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            rectangleCreatorButton.widthAnchor.constraint(equalToConstant: 150),
            rectangleCreatorButton.heightAnchor.constraint(equalToConstant: 150),
            
            photoCreatorButton.widthAnchor.constraint(equalToConstant: 150),
            photoCreatorButton.heightAnchor.constraint(equalToConstant: 150),
            
            
            sideView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sideView.widthAnchor.constraint(equalToConstant: 220),
            sideView.topAnchor.constraint(equalTo: self.topAnchor),
            sideView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            planeView.bottomAnchor.constraint(equalTo: self.rectangleCreatorButton.topAnchor),
            planeView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            planeView.topAnchor.constraint(equalTo: self.topAnchor),
            planeView.trailingAnchor.constraint(equalTo: self.sideView.leadingAnchor)
        ])
    }
    
    func addShape(shapeView: BaseShapeView) {
        shapeView.delegate = self
        planeView.addSubview(shapeView)
        
        NSLayoutConstraint.activate([
            shapeView.leadingAnchor.constraint(equalTo: planeView.leadingAnchor, constant: shapeView.frame.origin.x),
            shapeView.topAnchor.constraint(equalTo: planeView.topAnchor, constant: shapeView.frame.origin.y),
            shapeView.widthAnchor.constraint(equalToConstant: shapeView.frame.width),
            shapeView.heightAnchor.constraint(equalToConstant: shapeView.frame.height)
        ])
    }
    
    func addShape(tempView: UIView) {
        planeView.addSubview(tempView)
    }
    
    func planeViewBoundsSize() -> CGSize {
        return planeView.bounds.size
    }
    
    func shapeView(withID id: UUID) -> BaseShapeView? {
        return planeView.subviews
            .compactMap { $0 as? BaseShapeView }
            .first { $0.shapeID == id }
    }
}

// MARK: - ShapeCreatorButtonDelegate

extension CanvasView: ShapeCreatorButtonDelegate {
    func didTapShapeCreatorButton(_ button: ShapeCreatorButton, shapeCategory: ShapeCategory) {
        delegate?.didTapShapeCreatorButtonInCanvasView(self, shapeCategory: shapeCategory)
    }
}

// MARK: - RectangleTapGestureDelegate

extension CanvasView: ShapeViewDelegate {
    func didTapShapeView(_ shapeView: BaseShapeView) {
        delegate?.didTapGestureShapeView(self, shapeID: shapeView.shapeID)
    }
    
    func didPanShapeView(_ shapeView: BaseShapeView, sender: UIPanGestureRecognizer) {
        delegate?.didPanGestureShapeView(self, shapeID: shapeView.shapeID, sender: sender)
    }
    
    func updateSideView(shape: BaseShape) {
        sideView.updateShapeInfo(shape: shape)
    }
}

// MARK: - SideViewDelegate

extension CanvasView: SideViewDelegate {
    func didTapBackgroundColorChangeButton(_ sideView: SideView) {
        delegate?.didTapBackgroundColorChangeButton(self)
    }
    
    func didChangeAlphaSlider(_ sideView: SideView, changedValue: Float) {
        delegate?.didChangeAlphaSlider(self, changedValue: changedValue)
    }
}
