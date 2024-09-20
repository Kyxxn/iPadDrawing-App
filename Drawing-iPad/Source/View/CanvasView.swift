//
//  CanvasView.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import UIKit

protocol CanvasViewDelegate: AnyObject {
    func didTapShapeButtonInCanvasView(_ canvasView: CanvasView)
    func didTapGestureRectangle(_ canvasView: CanvasView, rectangleID: UUID)
    func didTapBackgroundColorChangeButton(_ canvasView: CanvasView)
    func didChangeAlphaSlider(_ canvasView: CanvasView, changedValue: Float)
}

final class CanvasView: UIView {
    // MARK: - Properties
    
    weak var delegate: CanvasViewDelegate?
    
    // MARK: - UI Components
    
    private let rectangleButton = ShapeCreatorButton(name: "사각형")
    private let sideView = SideView()
    private let planeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        rectangleButton.delegate = self
        sideView.delegate = self
        setupConfiguration()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func setupConfiguration() {
        self.addSubview(rectangleButton)
        self.addSubview(sideView)
        self.addSubview(planeView)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rectangleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rectangleButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            rectangleButton.widthAnchor.constraint(equalToConstant: 150),
            rectangleButton.heightAnchor.constraint(equalToConstant: 150),
            
            sideView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sideView.widthAnchor.constraint(equalToConstant: 220),
            sideView.topAnchor.constraint(equalTo: self.topAnchor),
            sideView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            planeView.bottomAnchor.constraint(equalTo: self.rectangleButton.topAnchor),
            planeView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            planeView.topAnchor.constraint(equalTo: self.topAnchor),
            planeView.trailingAnchor.constraint(equalTo: self.sideView.leadingAnchor)
        ])
    }
    
    func addRectangle(rectangleView: RectangleView) {
        rectangleView.delegate = self
        planeView.addSubview(rectangleView)
        
        NSLayoutConstraint.activate([
            rectangleView.leadingAnchor.constraint(equalTo: planeView.leadingAnchor, constant: rectangleView.frame.origin.x),
            rectangleView.topAnchor.constraint(equalTo: planeView.topAnchor, constant: rectangleView.frame.origin.y),
            rectangleView.widthAnchor.constraint(equalToConstant: rectangleView.frame.width),
            rectangleView.heightAnchor.constraint(equalToConstant: rectangleView.frame.height)
        ])
    }
    
    func planeViewBoundsSize() -> CGSize {
        return planeView.bounds.size
    }
    
    func rectangleView(withID id: UUID) -> RectangleView? {
        return planeView.subviews
            .compactMap { $0 as? RectangleView }
            .first { $0.rectangleID == id }
    }
}

// MARK: - ShapeCreatorButtonDelegate

extension CanvasView: ShapeCreatorButtonDelegate {
    func didTapShapeButton(_ button: ShapeCreatorButton) {
        print("캔버스뷰 델리게이트")
        delegate?.didTapShapeButtonInCanvasView(self)
    }
}

// MARK: - RectangleTapGestureDelegate

extension CanvasView: RectangleTapGestureDelegate {
    func didTapRectangleGesture(_ rectangleView: RectangleView) {
        delegate?.didTapGestureRectangle(self, rectangleID: rectangleView.rectangleID)
    }
    
    func updateSideView(rectangle: Rectangle) {
        sideView.updateRectangleInfo(rectangle: rectangle)
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
