//
//  RatingControl.swift
//  FoodTracker
//
//  Created by 株式会社シナブル on 2019/11/05.
//  Copyright © 2019 TaeseongYang. All rights reserved.
//

import UIKit

// IBDesignable을 통해 Interface Builder는 캔버스에서 직접 컨트롤 사본을 인스턴스화하고 그릴 수 있다. 또한
// Interface Builder에는 컨트롤의 라이브 사본이 있으므로 레이아웃 엔진이 컨트롤의 위치와 크기를 올바르게 지정할 수 있다.
@IBDesignable class RatingControl: UIStackView {
    
    // MARK: Properties
    
    // RatingControl 클래스 외의 어떤 것도 이 버튼에 액세스 하지 못하게 하기 위해 private로 선언
    private var ratingButtons = [UIButton]()
    
    // 컨트롤의 등급. 이 클래스 외부에서 값을 읽고 쓸 수 있어야 한다.
    var rating = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
        // fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    
    private func setupButtons() {

        // 다섯개의 버튼 생성
        // "_"는 와일드 카드를 나타내며 현재 실행중인 루프의 반복을 알 필요가 없을 때 사용할 수 있다.
        for _ in 0..<5 {
        
            // Create the button
            let button = UIButton()
            button.backgroundColor = UIColor.red
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            
            // Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // 스택에 버튼을 추가
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
        
            
            // 버튼 다섯개를 만들지만 버튼들 사이에 공백이 없기 때문에 하나의 긴 막대기처럼 보인다. 속성에서 공백 설정
            
        }
    }
    
    // MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        
        // Rating button(빨간색 부분)을 터치하면 콘솔창에 해당 문구 출력
        print("Button pressed ")
        
    }
    
    
    /*
     
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
     override func draw(_ rect: CGRect) {
        // Drawing code
    }
     
    */

}
