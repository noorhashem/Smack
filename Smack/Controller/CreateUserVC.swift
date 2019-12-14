//
//  CreateUserVC.swift
//  Smack
//
//  Created by McNoor's  on 11/24/19.
//  Copyright © 2019 McNoor's . All rights reserved.
//

import UIKit

class CreateUserVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usrImage: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if DataService.instance.avatarName != "" {
            usrImage.image = UIImage(named: DataService.instance.avatarName)
            avatarName = DataService.instance.avatarName
            
            if avatarName.contains("light") && usrImage.backgroundColor == nil {
                usrImage.backgroundColor = UIColor.gray
            }
        }
    }
        
        
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: "to_AvatarPicker", sender: nil)
    }
    
    @IBAction func changeBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255))/255
        let g = CGFloat(arc4random_uniform(255))/255
        let b = CGFloat(arc4random_uniform(255))/255
        UIView.animate(withDuration: 0.3) {
            self.usrImage.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 0.8)
        }
        
    }
    
    func setupView() {
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : SmackAppText ])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : SmackAppText ])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : SmackAppText ])
        
//        let tap = UIGestureRecognizer(target: self, action: #selector(handleTap))
//        view.addGestureRecognizer(tap)
    }
    

//    @objc func handleTap() {
//        view.endEditing(true)
//    }
    
    
    @IBAction func createUserPressed(_ sender: Any) {
        
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        guard let email = emailTxt.text, emailTxt.text != "" else {
            return
        }
        
        guard let password = passwordTxt.text, passwordTxt.text != "" else {
            return
        }
        
        guard let username = usernameTxt.text, usernameTxt.text != "" else {
            return
        }
        
        AuthService.instance.registerAccount(email: email, password: password, completion: { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        print("Account Registered & logged in Successfully")
                        AuthService.instance.createUser(name: username, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (success) in
                            if success {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: "to_channels", sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                            
                        }
                        
                        
                    }
                   
                })
                
            }
        })
        
    }
    


}
