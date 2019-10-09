//
//  ViewController.swift
//  TSProject
//
//  Created by 株式会社シナブル on 2019/09/25.
//  Copyright © 2019 株式会社シナブル. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    @IBAction func signIn(_ sender: Any) {
         GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
       
        let gSignIn = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 230, height: 48))
        gSignIn.center = view.center
        view.addSubview(gSignIn)
        
    }


}

