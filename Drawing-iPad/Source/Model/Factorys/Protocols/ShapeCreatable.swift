//
//  ShapeCreatable.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/20/24.
//

// TODO: 팩토리 구현 어떻게 할지 생각해보기
protocol ShapeCreatable {
    associatedtype ShapeType: (Shapable & AlphaControllable)
    
    func makeShape() -> ShapeType
}
