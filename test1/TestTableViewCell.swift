//
//  TestTableViewCell.swift
//  test1
//
//  Created by Eugene Tan on 17/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
