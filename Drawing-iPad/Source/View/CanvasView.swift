//
//  CanvasView.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/15/24.
//

import UIKit

final class CanvasView: UIView {
    private let rectangleButton = ShapeCreatorButton(name: "사각형")
    private let sideView = SideView()
    private let planeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
}
