//
//  AvatarCell.swift
//  Smack
//
//  Created by McNoor's  on 12/8/19.
//  Copyright © 2019 McNoor's . All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}
class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
    
    func configCell(index : Int , type: AvatarType){
        if type == .dark {
            self.layer.backgroundColor = UIColor.lightGray.cgColor
            avatarImage.image = UIImage(named: "dark\(index)")
        } else {
            self.layer.backgroundColor = UIColor.gray.cgColor
            avatarImage.image = UIImage(named: "light\(index)")
        }
    }
    
    
}
