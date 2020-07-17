//
//  CSLogButton.swift
//  Memo
//
//  Created by USER on 17/07/2020.
//  Copyright © 2020 USER. All rights reserved.
//

import UIKit

public enum CSLogType: Int{
    case basic
    case title
    case tag
}

class CSLogButton: UIButton {
    //로그 타입
    public var logType: CSLogType = .basic
    
    //스토리보드 방식으로 인스턴스 생성시 사용됨
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    
        self.addTarget(self, action: #selector(logging(_:)), for: .touchUpInside)
        
    }
    @objc func logging(_ sender: UIButton){
               switch self.logType{
               case .basic:
                   NSLog("버튼이 눌렸습니다.")
               case .title:
                   let btnTitle = sender.titleLabel?.text ?? "타이틀 없는"
                   NSLog("\(btnTitle) 버튼이 클릭되었습니다.")
               case .tag:
                   NSLog("\(sender.tag)버튼이 클릭되었습니다.")
               }
           }
}
