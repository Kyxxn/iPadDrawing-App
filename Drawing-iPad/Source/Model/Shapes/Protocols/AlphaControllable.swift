//
//  Alphaable.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/20/24.
//

protocol AlphaControllable {
    var alpha: Alpha { get }
    
    func updateAlpha(alpha: Alpha)
}
