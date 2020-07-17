//
//  MemoReadViewController.swift
//  Memo
//
//  Created by USER on 17/07/2020.
//  Copyright © 2020 USER. All rights reserved.
//

import UIKit

class MemoReadViewController: UIViewController {

    //MARK: - Properties
    
    //콘텐츠를 저장하는 변수
    var param: MemoData?
    
    @IBOutlet var subject: UILabel!
    @IBOutlet var contents: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func viewDidLoad() {

        //제목, 내용, 이미지 출력
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        //날짜 포맷 변환
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        //네비게이션 타이틀에 날짜 표시
        self.navigationItem.title = dateString
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
