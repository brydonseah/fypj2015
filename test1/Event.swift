//
//  Event.swift
//  test1
//
//  Created by fypjadmin on 23/3/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import Foundation
import UIKit

class Event: NSObject {
    var title: String
    var date: String
    var id: Int32
    var code: Int32
    
    init(title: String, date: String, id: Int32, code: Int32) {
        
        self.title = title
        self.date = date
        self.id = id
        self.code = code
        super.init()
    }
}
