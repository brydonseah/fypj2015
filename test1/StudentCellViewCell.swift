//
//  StudentCellViewCell.swift
//  test1
//
//  Created by fypjadmin on 12/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentCellViewCell: UITableViewCell {

    @IBOutlet var studentLabel: UILabel!
    @IBOutlet var studentImage: UIImageView!
    @IBOutlet var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
