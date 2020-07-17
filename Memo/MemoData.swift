//
//  MemoData.swift
//  Memo
//
//  Created by USER on 17/07/2020.
//  Copyright © 2020 USER. All rights reserved.
//

import UIKit
import CoreData

class MemoData{
    var memoIdx: Int?
    var title: String?
    var contents: String?
    var image: UIImage?
    var regdate: Date?
    
    //원본 MemoMO 객체를 참조하기 위한 속성
    var objectID: NSManagedObjectID?
}
