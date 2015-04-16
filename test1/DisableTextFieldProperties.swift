//
//  DisableTextFieldProperties.swift
//  test1
//
//  Created by fypjadmin on 16/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class DisableTextFieldProperties: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == "paste:" {
            return false
        }
        if action == "copy:" {
            return false
        }
        if action == "replacement:" {
            return false
        }
        if action == "select:" {
            return false
        }
        if action == "selectAll:" {
            return false
        }
        if action == "cut:"{
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }

}
