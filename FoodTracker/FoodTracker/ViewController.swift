//
//  ViewController.swift
//  FoodTracker
//
//  Created by 株式会社シナブル on 2019/10/21.
//  Copyright © 2019 TaeseongYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK : Properties
    @IBOutlet var nametextField: UITextField!
    @IBOutlet var mealNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK : Actions
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
    
        mealNameLabel.text = "Default Text"
        
    }
}

