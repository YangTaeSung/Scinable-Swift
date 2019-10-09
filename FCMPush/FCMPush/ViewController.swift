//
//  ViewController.swift
//  FCMPush
//
//  Created by 株式会社シナブル on 2019/09/03.
//  Copyright © 2019 株式会社シナブル. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    
    


}

