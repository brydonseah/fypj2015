//
//  ForgotPassViewController.swift
//  test1
//
//  Created by fypjadmin on 22/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class ForgotPassViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    var ref = Firebase(url: "https://quest2015.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitEmail(sender: UIButton){
        ref.resetPasswordForUser("\(self.emailTextField.text)", withCompletionBlock: { error in
            if error != nil {
                // There was an error processing the request
                var errorAlert = UIAlertController(title: "Please check your email again. No such email registered.", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                }))
                
                self.presentViewController(errorAlert, animated: true, completion: nil)

            } else {
                var successAlert = UIAlertController(title: "Please check your email for the temporary password.", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                successAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    self.performSegueWithIdentifier("unwindMain", sender: self)
                }))
                
                self.presentViewController(successAlert, animated: true, completion: nil)
                // Password reset sent successfully
            }
        })
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
