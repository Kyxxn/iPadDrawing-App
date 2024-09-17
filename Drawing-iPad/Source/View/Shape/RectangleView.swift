//
//  RectangleView.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/17/24.
//

import UIKit

final class RectangleView: UIView {
    func setupFromModel(rectangle: Rectangle) {
        self.frame.origin = rectangle.origin.toCGPoint
        self.frame.size = rectangle.size.toCGSize
        self.backgroundColor = UIColor(
            red: CGFloat(rectangle.color.red),
            green: CGFloat(rectangle.color.green),
            blue: CGFloat(rectangle.color.blue),
            alpha: rectangle.alpha.toCGFloat
        )
    }
}
