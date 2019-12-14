//
//  GradientView.swift
//  Smack
//
//  Created by McNoor's  on 11/24/19.
//  Copyright © 2019 McNoor's . All rights reserved.
//

import UIKit
@IBDesignable

class GradientView: UIView {
    @IBInspectable var topColor : UIColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.1647058824, alpha: 1)
    {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    
    @IBInspectable var bottomColor : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
