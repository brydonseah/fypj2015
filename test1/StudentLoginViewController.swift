//
//  StudentLoginViewController.swift
//  test1
//
//  Created by fypjadmin on 25/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentLoginViewController: UIViewController {
    @IBOutlet var passcodeTextField: UITextField!
    @IBOutlet var enterButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func studentLogin(sender: UIButton){
        if(self.passcodeTextField.text == "1234") {
        self.performSegueWithIdentifier("studentLogin", sender: self)
        } else {
            let alert = UIAlertView()
            alert.title = "Wrong passcode!"
            alert.message = ""
            alert.addButtonWithTitle("Ok")
            alert.show()

        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "studentLogin"){
        }
    }
    

}
