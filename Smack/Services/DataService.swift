//
//  DataService.swift
//  Smack
//
//  Created by McNoor's  on 11/26/19.
//  Copyright © 2019 McNoor's . All rights reserved.
//

import Foundation

class DataService {
    
    static let instance = DataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, name: String, email: String, color: String, avatarName: String) {
        self.id = id
        self.name = name
        self.email = email
        self.avatarColor = color
        self.avatarName = avatarName
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    
    
}
