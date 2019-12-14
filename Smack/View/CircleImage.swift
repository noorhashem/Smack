//
//  CircleImage.swift
//  Smack
//
//  Created by McNoor's  on 12/12/19.
//  Copyright © 2019 McNoor's . All rights reserved.
//

import UIKit

@IBDesignable

class CircleImage: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
