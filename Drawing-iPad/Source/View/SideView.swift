//
//  SideView.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/17/24.
//

import UIKit

final class SideView: UIView {
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
        backgroundColor = .systemGray5
    }
}
