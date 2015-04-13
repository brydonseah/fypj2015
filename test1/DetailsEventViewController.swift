//
//  DetailsEventViewController.swift
//  test1
//
//  Created by fypjadmin on 10/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class DetailsEventViewController: UIViewController {

    @IBOutlet var eventNameTextField: UITextField!
    @IBOutlet var dateTimeEventTextField: UITextField!
    
    var nameEvent: String!
    var dateTimeEvent: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
        
        eventNameTextField.text = nameEvent
        dateTimeEventTextField.text = dateTimeEvent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
            
        
    }
    
    
    
    
    
    

}
