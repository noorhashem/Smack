//
//  ChatVC.swift
//  Smack
//
//  Created by McNoor's  on 11/23/19.
//  Copyright © 2019 McNoor's . All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //Outlets
    @IBOutlet weak var menuBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBttn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_ :)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

    }
    

}
