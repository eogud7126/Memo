//
//  MemoTableViewController.swift
//  Memo
//
//  Created by USER on 17/07/2020.
//  Copyright © 2020 USER. All rights reserved.
//

import UIKit

class MemoTableViewController: UITableViewController, UISearchBarDelegate {

    //앱 델리게이트 참조 정보 가져옴
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    lazy var dao = MemoDAO()
    @IBOutlet var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //검색바에 아무것도 누르지 않아도 리턴키 누를 수 있도록
        searchBar.enablesReturnKeyAutomatically = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //뷰가 화면에 출력되면 호출
    override func viewWillAppear(_ animated: Bool) {
        
        //코어 데이터에 저장된 데이터를 가져옴
        self.appDelegate.memolist = self.dao.fetch()
        
        //테이블 데이터 리로드
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //셀의 개수 결정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.appDelegate.memolist.count
    }

    //개별 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //memolist 배열에서 주어진 행에 맞는 데이터 꺼냄
        let row = self.appDelegate.memolist[indexPath.row]
        
        //*******이미지 속성이 비어있고 없고에 따라 프로토타입 셀 식별자를 변경*******
        let cellId = row.image == nil ? "memoCell" : "memoCellwithImage"
        
        //재사용 큐로부터 프로토타입 셀의 인스턴스를 전달 받음
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MemoTableViewCell
        
        //내용 구성
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        
        //Date타입의 날짜를 포맷에 맞게 변경
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = formatter.string(from: row.regdate!)

        // Configure the cell...

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //memolist에서 선택된 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
        
        //상세화면 인스턴스 생성
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadViewController else{
            return
        }
        
        //값을 전달한 다음 상세 화면으로 이동
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let data = self.appDelegate.memolist[indexPath.row]
        
        //코어 데이터에서 삭제하고 배열 내 데이터, 테이블 뷰 행을 삭제한다.
        if dao.delete(data.objectID!) {
            self.appDelegate.memolist.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    
    //UISearchBar DataSource
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keyword = searchBar.text //검색바의 텍스트 가져옴
        
        //데이터 검색, 테이블 뷰 갱신
        self.appDelegate.memolist = self.dao.fetch(keyword: keyword)
        self.tableView.reloadData()
    }


}
