//
//  AuthService.swift
//  Smack
//
//  Created by McNoor's  on 11/24/19.
//  Copyright © 2019 McNoor's . All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    let defaults = UserDefaults.standard
    
    var isLoggedIn :Bool {
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerAccount(email : String , password : String, completion : @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        let header = HEADER
        let body = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        Alamofire.request(REGISTER_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString( completionHandler: { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        })
        
    }
    
    func loginUser (email : String , password: String, completion : @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        let header = HEADER
        let body = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        Alamofire.request(LOG_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON( completionHandler:
            { (response) in
            if response.result.error == nil {
                completion(true)
                self.isLoggedIn = true
                if let json = response.result.value as? [String : Any] {
                    if let email = json["user"] as? String {
                        self.userEmail = email
                        
                    }
                    if let token = json["token"] as? String {
                        self.authToken = token
                    }
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        })
        
    }
    
    func createUser(name:String, email: String, avatarName:String, avatarColor:String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        let header = [
            "Authorization":"Bearer \(AuthService.instance.authToken)",
            "Content-Type":"application/json; charset=utf-8"
        ]
        let body = [
            "name" : name,
            "email" : lowerCaseEmail,
            "avatarName" : avatarName,
            "avatarColor" : avatarColor

        ]


         Alamofire.request(CREATE_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: {
            (response) in
            if response.result.error == nil {
                guard let jsonObj = response.data else { return }

                if let json = try? JSON(data: jsonObj){

                    let id = json["_id"].stringValue
                    let color = json["avatarColor"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let email = json["email"].stringValue
                    let name = json["name"].stringValue
                    
                    DataService.instance.setUserData(id: id, name: name, email: email, color: color , avatarName: avatarName)
                    completion(true)

                }


            }
            else {
                print("I'm false")
                completion(false)
                debugPrint(response.result.error as Any)
            }

        })
    }

}
