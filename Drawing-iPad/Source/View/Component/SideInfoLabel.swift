//
//  SideInfoLabel.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/18/24.
//

import UIKit

final class SideInfoLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        setupConfiguration(text: text)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConfiguration(text: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
        self.textColor = .black
        self.text = text
    }
}
