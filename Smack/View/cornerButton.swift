//
//  cornerButton.swift
//  Smack
//
//  Created by McNoor's  on 11/25/19.
//  Copyright © 2019 McNoor's . All rights reserved.
//

import Foundation
@IBDesignable

class cornerButton : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.3 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
        
    }
    
    func updateView() {
        self.layer.cornerRadius = cornerRadius
    }
    
    override func awakeFromNib() {
        self.updateView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.updateView()
    }
    
}
