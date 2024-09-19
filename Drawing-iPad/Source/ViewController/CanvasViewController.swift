//
//  ViewController.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/14/24.
//

import UIKit

final class CanvasViewController: UIViewController {
    private let canvasView = CanvasView()
    private var factory: RectangleFactory?
    private let plane = Plane()
    private var selectedRectangleView: RectangleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        canvasView.delegate = self
        
        setupConfiguration()
        setupNotificationAddObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        factory = RectangleFactory(viewBoundsSize: canvasView.planeViewBoundsSize())
    }
    
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
            selector: #selector(handleRectangleChanged),
            name: .rectangleUpdated,
            object: nil
        )
    }
    
    @objc private func handlePlaneChanged() {
        print("CanvasViewController handlePlaneChanged")
    }
    
    @objc private func handleRectangleChanged(_ notification: Notification) {
        if let updatedRectangle = notification.object as? Rectangle {
            canvasView.updateSideView(rectangle: updatedRectangle)
        }
    }
}

// MARK: - CanvasViewDelegate

extension CanvasViewController: CanvasViewDelegate {
    func didTapShapeButtonInCanvasView(_ canvasView: CanvasView) {
        guard let rectangle = factory?.makeRectangle() else { return }
        plane.appendRectangle(rectangle: rectangle)
        createRectangle(rectangle)
    }
    
    private func createRectangle(_ rectangle: Rectangle) {
        let rectangleView = RectangleView(rectangleID: rectangle.identifier)
        rectangleView.setupFromModel(rectangle: rectangle)
        canvasView.addRectangle(rectangleView: rectangleView)
    }
    
    func didTapGestureRectangle(_ canvasView: CanvasView,
                                rectangleID: UUID) {
        if let previousSelectedView = selectedRectangleView {
            previousSelectedView.isSelected = false
        }
        
        guard let rectangleView = canvasView.rectangleView(withID: rectangleID),
              let rectangle = plane.rectangle(withID: rectangleID) else { return }
        
        rectangleView.isSelected = true
        selectedRectangleView = rectangleView
        
        canvasView.updateSideView(rectangle: rectangle)
    }
    
    func didTapBackgroundColorChangeButton(_ canvasView: CanvasView) {
        guard let rectangleView = selectedRectangleView,
              let rectangle = plane.rectangle(withID: rectangleView.rectangleID) else { return }
        let newColor = RandomFactory.makeRandomColor()
        
        rectangleView.backgroundColor = UIColor(
            red: CGFloat(newColor.red) / 255.0,
            green: CGFloat(newColor.green) / 255.0,
            blue: CGFloat(newColor.blue) / 255.0,
            alpha: selectedRectangleView?.alpha ?? .zero
        )
        rectangle.updateColor(color: newColor)
    }
    
    func didChangeAlphaSlider(_ canvasView: CanvasView, changedValue: Float) {
        guard let rectangleView = selectedRectangleView,
              let rectangle = plane.rectangle(withID: rectangleView.rectangleID) else { return }
        rectangleView.alpha = CGFloat(changedValue) / 10.0
        
        if let newAlpha = Alpha.from(floatValue: changedValue) {
            rectangle.updateAlpha(alpha: newAlpha)
        }
    }
}
