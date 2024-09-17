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

extension CanvasViewController: CanvasViewDelegate {
    func didTapShapeButtonInCanvasView(_ canvasView: CanvasView) {
        let rectangle = factory?.makeRectangle()
        createRectangle(rectangle)
    }
    private func createRectangle(_ rectangle: Rectangle?) {
        guard let rectangle = rectangle else { return }
        let rectangleView = RectangleView()
        rectangleView.setupFromModel(rectangle: rectangle)
        canvasView.addRectangle(rectangleView: rectangleView)
    }
}
