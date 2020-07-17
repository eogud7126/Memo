//
//  MemoFormViewController.swift
//  Memo
//
//  Created by USER on 17/07/2020.
//  Copyright © 2020 USER. All rights reserved.
//

import UIKit

class MemoFormViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    //MARK: Properties
    var subject: String!    //제목
    
    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    override func viewDidLoad() {
        self.contents.delegate = self

    }
    
    //MAKR: Actions
    //저장버튼
    @IBAction func save(_ sender: Any) {
        //내용을 입력하지 않은경우 경고
        guard self.contents.text?.isEmpty == false else{
            let alert = UIAlertController(title: nil, message: "내용을 입력하세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        //MemoData 객체를 생성하고 데이터를 담음
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        //앱 델리게이트 객체를 읽어 memolist 배열에 MemoData 객체를 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        //작성 폼 화면을 종료 후 이전 화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //이미지선택
    @IBAction func pick(_ sender: Any) {
        //이미지 피커 인스턴스 생성
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        //알림창 객체 생성
        let alert = UIAlertController(title: nil, message: "이미지를 가져올 곳을 선택해주세요", preferredStyle: .actionSheet)
        
        //카메라
        let camera = UIAlertAction(title: "카메라", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                picker.sourceType = .camera
                //이미지 피커 화면 표시
                self.present(picker, animated: false)
            }
        }
        //저장 앨범
        let savedAlbum = UIAlertAction(title: "저장앨범", style: .default) {(_) in
            picker.sourceType = .savedPhotosAlbum
            self.present(picker, animated: false)
        }
        //사진 라이브러리
        let photoLibrary = UIAlertAction(title: "사진 라이브러리", style: .default){ (_) in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: false)
        }
        
        //취소
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(camera)
        alert.addAction(savedAlbum)
        alert.addAction(photoLibrary)
        alert.addAction(cancel)
        
        //알림창 실행
        self.present(alert, animated: false)
        
    }
    
    //MARK: UITextViewDelegate
    
    //텍스트 뷰의 내용이 변경될 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        //내용의 15자리까지 읽어 subject(제목)에 저장
        let contents = textView.text as NSString    //NSString 추출할 수 있는 메소드 있음
        let length = (contents.length > 15) ? 15: contents.length
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        //네비게이션 타이틀에 표시
        self.navigationItem.title = subject
    }
    
    
    
    
    //MARK: UIImagePickerControllerDelegate
    
    //이미지 선택을 완료했을 때 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //미리보기에 표시
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        //이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
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
