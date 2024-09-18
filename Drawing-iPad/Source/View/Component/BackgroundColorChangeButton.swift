//
//  BackgroundColorChangeButton.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/18/24.
//

import UIKit

final class BackgroundColorChangeButton: UIButton {
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
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
        self.setTitleColor(.black, for: .normal)
        self.setTitle("None", for: .normal)
    }
}
