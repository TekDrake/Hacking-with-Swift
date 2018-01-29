//
//  GradientView.swift
//  Project37
//
//  Created by Juan Garcia on 1/26/18.
//  Copyright © 2018 Juan Garcia. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var topColor: UIColor = UIColor.white 
    @IBInspectable var bottomColor: UIColor = UIColor.black
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
    }
}
