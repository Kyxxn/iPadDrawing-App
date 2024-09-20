//
//  Colorable.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/20/24.
//

protocol Colorable {
    var color: Color { get }
    
    func updateColor(color: Color)
}
