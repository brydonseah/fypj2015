//
//  NoRadioButton.swift
//  test1
//
//  Created by fypjadmin on 26/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class NoRadioButton: UIButton {
    
    
    
    let checkedImg = UIImage(named:"checked")
    let unCheckedImg = UIImage(named: "unchecked_checkbox")
    
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true{
                self.setImage(checkedImg, forState: .Normal)
            } else {
                self.setImage(unCheckedImg, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked (sender: UIButton) {
        if (sender == self) {
            if isChecked == true {
                isChecked == false
            } else {
                isChecked == true
            }
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
