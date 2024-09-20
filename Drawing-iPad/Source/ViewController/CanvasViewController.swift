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
    private var selectedRectangleView: RectangleView?
    
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
        switch shapeCategory {
        case .rectangle:
            factory = RectangleFactory(viewBoundsSize: canvasView.planeViewBoundsSize())
        case .photo:
            factory = PhotoFactory(viewBoundsSize: canvasView.planeViewBoundsSize())
        }
        
        if let photoFactory = factory as? PhotoFactory {
            let imageURL = URL(string: "temp")!
            let photo = photoFactory.makeShape(imageURL: imageURL)
            plane.appendShape(shape: photo)
            createShape(photo)
        } else if let shape = factory?.makeShape() as? Rectangle {
            plane.appendShape(shape: shape)
            createShape(shape)
        }
    }
    
    private func createShape(_ shape: BaseShape) {
        let rectangleView = RectangleView(rectangleID: shape.identifier)
        rectangleView.setupFromModel(shape: shape)
        canvasView.addRectangle(rectangleView: rectangleView)
    }
    
    func didTapGestureRectangle(_ canvasView: CanvasView,
                                rectangleID: UUID) {
        if let previousSelectedView = selectedRectangleView {
            previousSelectedView.isSelected = false
        }
        
        guard let rectangleView = canvasView.rectangleView(withID: rectangleID),
              let shape = plane.findShape(withID: rectangleID) else { return }
        
        rectangleView.isSelected = true
        selectedRectangleView = rectangleView
        
        canvasView.updateSideView(shape: shape)
    }
    
    func didTapBackgroundColorChangeButton(_ canvasView: CanvasView) {
        guard let rectangleView = selectedRectangleView,
              let shape = plane.findShape(withID: rectangleView.rectangleID) as? Rectangle else { return }
        let newColor = RandomFactory.makeRandomColor()
        
        rectangleView.backgroundColor = UIColor(
            red: CGFloat(newColor.red) / 255.0,
            green: CGFloat(newColor.green) / 255.0,
            blue: CGFloat(newColor.blue) / 255.0,
            alpha: selectedRectangleView?.alpha ?? .zero
        )
        shape.updateColor(color: newColor)
    }
    
    func didChangeAlphaSlider(_ canvasView: CanvasView, changedValue: Float) {
        guard let rectangleView = selectedRectangleView,
              let shape = plane.findShape(withID: rectangleView.rectangleID) else { return }
        rectangleView.alpha = CGFloat(changedValue) / 10.0
        
        if let newAlpha = Alpha.from(floatValue: changedValue) {
            shape.updateAlpha(alpha: newAlpha)
        }
    }
}
