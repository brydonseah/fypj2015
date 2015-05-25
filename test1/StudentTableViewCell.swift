//
//  StudentTableViewCell.swift
//  test1
//
//  Created by fypjadmin on 25/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet var genderImg: UIImageView!
    
    @IBOutlet var studentLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
