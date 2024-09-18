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
}
