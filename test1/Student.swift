//
//  Student.swift
//  test1
//
//  Created by fypjadmin on 14/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Student : NSObject {
    
    var studentID: Int32
    var name: String
    var category: String
    
    
    
    init(studentID: Int32, name: String, category: String) {
        
        self.studentID = studentID
        self.name = name
        self.category = category
        super.init()
    }


}
