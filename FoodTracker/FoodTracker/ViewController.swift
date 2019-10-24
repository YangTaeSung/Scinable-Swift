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
// UIImagePickerController의 Delegate로 설정할 때 UINavigationControllerDelegate가 필요하다.
class ViewController: UIViewController, UISearchTextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK : Properties
    @IBOutlet var nametextField: UITextField!
    @IBOutlet var mealNameLabel: UILabel!
    
    /*
     이미지뷰는 컨트롤이 아니므로 버튼이나 슬라이더와 같은 방식으로 입력에 응답하도록 설계되지 않았습니다.
     예를 들어 사용자가 이미지뷰를 누를 때 트리거되는 동작 방법을 만들 수는 없습니다. 이미지뷰에서 코드로
     Control- 드래그하려고 하면 연결 필드에서 동작을 선택할 수 없습니다.
     다행히 Gesture recognizers를 추가하여 컨트롤과 동일한 기능을 뷰에 제공하는 것은 매우 쉽습니다.
     Gesture recognizers는 컨트롤이 하는 방식으로 뷰가 사용자에게 응답할 수 있도록 보기에 연결하는
     개체입니다. Gesture recognizers는 터치를 해석하여 스와이프, 핀치 또는 회전과 같은 특정 제스처에
     해당하는지 확인합니다. Gesture recognizers가 할당 된 제스처를 인식 할 때 호출되는 동작 메소드를
     작성할 수 있습니다.
     Tab Gesture recognizers(UITapGestureRecognizer)를 이미지뷰에 연결하면 사용자가 이미지뷰를
     탭했을 때 인식됩니다. 스토리 보드에서 쉽게 할 수 있습니다.
     */
    @IBOutlet var photoImageView: UIImageView!
    
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
    
    
    // Mark : UIImagePickerControllerDelegate
    
    // 사용자가 이미지 선택기의 취소 버튼을 탭하면 호출됩니다.
    func imagePickerControllerDidCancel(_ picker : UIImagePickerController) {
        
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
        
    }
    
    
    // 이 메소드는 사용자가 선택 도구에서 선택한 이미지로 무언가를 할 수 있습니다. 본 프로젝트에서 이 메소드는 사용자 기기에서 선택한 이미지를 가져와 이미지뷰에 표시하는 작업을 합니다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // 선택된 사진이 종횡비를 고려하면서 ImageView영역 내의 가능한 한 많은 화면을 채우도록 한다.
            photoImageView.contentMode = .scaleAspectFit
        
            // 이미지뷰 콘센트에서 선택한 이미지 설정
            // Set photoImageView to display the selected image
            photoImageView.image = selectedImage
        
        }
        
        else {
        
            // Something bad
            fatalError("Expected a dictionary containing an image, but was provided the following: ¥(info)")
        
        }
                
        // 이미지 선택기를 닫음.
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK : Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        /* 이 코드는 사용자가 텍스트 필드에 입력하는 동안 이미지보기를 탭하면 키보드가 올바르게 닫히도록 합니다. */
        // Hide the keyboard.
        nametextField.resignFirstResponder()
        
        /* Image picker controller 생성 */
        // UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
    
        /* 이 코드는 ImagePickerController의 소스 또는 이미지를 가져오는 위치를 설정합니다. 이 .photoLibrary옵션은 시뮬레이터의
         카메라 롤을 사용합니다. */
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        /* ImagePickerController의 대리자를 ViewController로 설정 */
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
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

