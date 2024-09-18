//
//  SideView.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/17/24.
//

import UIKit

final class SideView: UIView {
    private let backgroundInfoLabel = SideInfoLabel(text: "배경색")
    private let backgroundColorChangeButton = BackgroundColorChangeButton()
    private let alphaSlider = AlphaSlider()
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupConfiguration()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray5
        self.addSubview(verticalStackView)
        [backgroundInfoLabel, backgroundColorChangeButton, alphaSlider].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            backgroundInfoLabel.widthAnchor.constraint(equalToConstant: 160),
            backgroundColorChangeButton.widthAnchor.constraint(equalToConstant: 160),
            backgroundColorChangeButton.heightAnchor.constraint(equalToConstant: 50),
            alphaSlider.widthAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    func resetSideComponenet() {
        backgroundColorChangeButton.setTitle("None", for: .normal)
        alphaSlider.isEnabled = false
    }
    
    func updateRectangleInfo(rectangle: Rectangle) {
        backgroundColorChangeButton.setTitle(rectangle.color.toHexCode,
                                             for: .normal)
        alphaSlider.isEnabled = true
        alphaSlider.value = rectangle.alpha.toFloat
    }
}
