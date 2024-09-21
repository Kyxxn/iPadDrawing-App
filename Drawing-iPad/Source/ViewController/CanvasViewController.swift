//
//  ViewController.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/14/24.
//

import UIKit

final class CanvasViewController: UIViewController {
    // MARK: - Properties
    
    private let canvasView = CanvasView()
    private var factory: (any ShapeCreatable)?
    private let plane = Plane()
    private var selectedShapeView: BaseShapeView?
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        canvasView.delegate = self
        
        setupConfiguration()
        setupNotificationAddObserver()
    }
    
    // MARK: - Method
    
    private func setupConfiguration() {
        view.addSubview(canvasView)
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvasView.topAnchor.constraint(equalTo: view.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNotificationAddObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePlaneChanged),
            name: .planeUpdated,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleShapeChanged),
            name: .shapeUpdated,
            object: nil
        )
    }
    
    @objc private func handlePlaneChanged() {
        print("CanvasViewController handlePlaneChanged")
    }
    
    @objc private func handleShapeChanged(_ notification: Notification) {
        if let updatedShape = notification.object as? BaseShape {
            canvasView.updateSideView(shape: updatedShape)
        }
    }
}

// MARK: - CanvasViewDelegate

extension CanvasViewController: CanvasViewDelegate {
    func didTapShapeCreatorButtonInCanvasView(_ canvasView: CanvasView, shapeCategory: ShapeCategory) {
        let shape: BaseShape
        
        switch shapeCategory {
        case .rectangle:
            let factory = RectangleFactory(viewBoundsSize: canvasView.planeViewBoundsSize())
            shape = factory.makeShape()
        case .photo:
            let factory = PhotoFactory(viewBoundsSize: canvasView.planeViewBoundsSize())
            let imageURL = URL(string: "temp")!
            shape = factory.makeShape(imageURL: imageURL)
        }
        
        plane.appendShape(shape: shape)
        createShape(shape)
    }
    
    private func createShape(_ shape: BaseShape) {
        let shapeView = BaseShapeView(shapeID: shape.identifier)
        shapeView.setupFromModel(shape: shape)
        canvasView.addRectangle(rectangleView: shapeView)
    }
    
    func didTapGestureRectangle(_ canvasView: CanvasView,
                                rectangleID: UUID) {
        if let previousSelectedView = selectedShapeView {
            previousSelectedView.isSelected = false
        }
        
        guard let rectangleView = canvasView.rectangleView(withID: rectangleID),
              let shape = plane.findShape(withID: rectangleID) else { return }
        
        rectangleView.isSelected = true
        selectedShapeView = rectangleView
        
        canvasView.updateSideView(shape: shape)
    }
    
    func didTapBackgroundColorChangeButton(_ canvasView: CanvasView) {
        guard let shapeView = selectedShapeView,
              let shape = plane.findShape(withID: shapeView.shapeID) as? Rectangle else { return }
        let newColor = RandomFactory.makeRandomColor()
        
        shapeView.backgroundColor = UIColor(
            red: CGFloat(newColor.red) / 255.0,
            green: CGFloat(newColor.green) / 255.0,
            blue: CGFloat(newColor.blue) / 255.0,
            alpha: selectedShapeView?.alpha ?? .zero
        )
        shape.updateColor(color: newColor)
    }
    
    func didChangeAlphaSlider(_ canvasView: CanvasView, changedValue: Float) {
        guard let shapeView = selectedShapeView,
              let shape = plane.findShape(withID: shapeView.shapeID) else { return }
        shapeView.alpha = CGFloat(changedValue) / 10.0
        
        if let newAlpha = Alpha.from(floatValue: changedValue) {
            shape.updateAlpha(alpha: newAlpha)
        }
    }
}
