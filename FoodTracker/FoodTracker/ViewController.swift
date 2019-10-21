//
//  ViewController.swift
//  FoodTracker
//
//  Created by 株式会社シナブル on 2019/10/21.
//  Copyright © 2019 TaeseongYang. All rights reserved.
//

import UIKit

// 텍스트필드의 대리자를 정의하는 프로토콜 UISearchTextFieldDelegate
// 즉 텍스트 입력을 처리하기 위해 프로토콜의 메소드를 구현할 수 있으며
// ViewController 클래스의 인스턴스를 텍스트 필드의 대리자로 할당 할 수 있다.
class ViewController: UIViewController, UISearchTextFieldDelegate {

    // MARK : Properties
    @IBOutlet var nametextField: UITextField!
    @IBOutlet var mealNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Handle the text field's user input through delegate callbacks.
        nametextField.delegate = self
    }

    // MARK : UITextFieldDelegate
    
    // 첫번째 응답자를 resign한다.(다음 응답자의 액션을 받기 위해서)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    
    }
    
    // 앞전의 응답자가 resign되었기 때문에 다음 액션을 취한다.
    // 텍스트필드를 탭하면 입력상자가 올라오고 문자를 입력한 후에 입력상자가 내려가면 라벨의 텍스트가 텍스트필드의 입력내용과 똑같이 바뀜.
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        mealNameLabel.text = textField.text
        
    }
    
    // MARK : Actions
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
    
        mealNameLabel.text = "Default Text"
        
    }
    /*********************************************************/
    /*
     
     Event : 사용자가 Set Default Label Text를 탭하는 것
     Action : setDefaultLabelTex(_) 메소드
     Target : ViewController(Action 메소드가 정의된 위치 - mealNameLabel)
     Sender : Set Default Label 버튼
     
     */
    /*********************************************************/
}

