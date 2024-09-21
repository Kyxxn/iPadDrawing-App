//
//  ViewController.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/14/24.
//

import UIKit
import PhotosUI

final class CanvasViewController: UIViewController {
    // MARK: Properties
    
    private let canvasView = CanvasView()
    private var factory: (any ShapeCreatable)?
    private let plane = Plane()
    private var selectedShapeView: BaseShapeView?
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        canvasView.delegate = self
        
        setupConfiguration()
        setupNotificationAddObserver()
    }
    
    // MARK: Method
    
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
    // MARK: ShapeModel & ShapeView Creator
    
    func didTapShapeCreatorButtonInCanvasView(_ canvasView: CanvasView, shapeCategory: ShapeCategory) {
        switch shapeCategory {
        case .rectangle:
            let shape = createRectangle()
            plane.appendShape(shape: shape)
        case .photo:
            presentPhotoPicker()
        }
    }
    
    private func createRectangle() -> BaseShape {
        let factory = RectangleFactory(viewBoundsSize: canvasView.planeViewBoundsSize())
        let rectangle = factory.makeShape()
        let rectangleView = RectangleView(shapeID: rectangle.identifier)
        rectangleView.setupFromModel(shape: rectangle)
        canvasView.addShape(shapeView: rectangleView)
        
        return rectangle
    }
    
    private func presentPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let phPickerViewController = PHPickerViewController(configuration: configuration)
        phPickerViewController.delegate = self
        present(phPickerViewController, animated: true)
    }
    
    // MARK: Tap Gesture
    
    func didTapGestureShapeView(_ canvasView: CanvasView,
                                shapeID: UUID) {
        if let previousSelectedView = selectedShapeView {
            previousSelectedView.isSelected = false
        }
        
        guard let shapeView = canvasView.shapeView(withID: shapeID),
              let shape = plane.findShape(withID: shapeID) else { return }
        
        shapeView.isSelected = true
        selectedShapeView = shapeView
        
        canvasView.updateSideView(shape: shape)
    }
    
    // MARK: SideView
    
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

// MARK: - PHPickerViewControllerDelegate

extension CanvasViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let provider = results.first?.itemProvider else { return }
        provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            guard let self = self,
                  let selectedimage = image as? UIImage,
                  let data = selectedimage.pngData() else { return }
            
            DispatchQueue.main.async {
                guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
                let fileName = UUID().uuidString + ".png"
                let imageURL = documents.appending(path: fileName, directoryHint: .notDirectory)
                self.createPhoto(imageURL: imageURL)
            }
        }
    }
    
    private func createPhoto(imageURL: URL) {
        let factory = PhotoFactory(viewBoundsSize: canvasView.planeViewBoundsSize())
        let photo = factory.makeShape(imageURL: imageURL)
        
        let image = UIImage(contentsOfFile: imageURL.path)
        let photoImageView = UIImageView(image: image)
        let photoView = PhotoView(imageView: photoImageView, shapeID: photo.identifier)
        photoView.setupFromModel(shape: photo)
        canvasView.addShape(shapeView: photoView)
        
        plane.appendShape(shape: photo)
    }
}
