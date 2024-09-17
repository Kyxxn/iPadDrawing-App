//
//  AlphaSlider.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/18/24.
//

import UIKit

final class AlphaSlider: UISlider {
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
        self.minimumValue = 1.0
        self.maximumValue = 10.0
    }
}
