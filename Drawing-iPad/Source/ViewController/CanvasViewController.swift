//
//  ViewController.swift
//  Drawing-iPad
//
//  Created by 박효준 on 9/14/24.
//

import UIKit

final class CanvasViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let factory = RectangleFactory(planeSize: view.bounds.size)
        print(factory.makeRectangle())
        print(factory.makeRectangle())
        print(factory.makeRectangle())
        print(factory.makeRectangle())
    }
}

