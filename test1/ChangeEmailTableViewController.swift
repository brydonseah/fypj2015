//
//  ChangeEmailTableViewController.swift
//  test1
//
//  Created by Eugene Tan on 25/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class ChangeEmailTableViewController: UITableViewController {
    @IBOutlet var confirmEmailTextField: UITextField!
    @IBOutlet var newEmailTextField: UITextField!
    @IBOutlet var currentEmailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    
    var ref = Firebase(url: "https://quest2015.firebaseio.com/")
    var getUserRef = Firebase(url: "https://quest2015.firebaseio.com/users")
    var email: String!
    var pass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        getUserRef.observeEventType(.ChildAdded, withBlock: {snapshot in
            
            let userEmail = snapshot.value["email"] as! String
            let userPass = snapshot.value["password"] as! String
            
            println("The user email is \(userEmail)")
            println("\(userPass)")
            
            self.email = userEmail
            self.pass = userPass
            
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveEmail(sender: UIBarButtonItem){
        if (newEmailTextField.text == confirmEmailTextField.text && currentEmailTextField.text == self.email){
            ref.changeEmailForUser("\(currentEmailTextField.text)", password: "\(self.passTextField.text)",
                toNewEmail: "\(confirmEmailTextField.text)", withCompletionBlock: { error in
                    if error != nil {
                        // There was an error processing the request
                        let alert = UIAlertView()
                        alert.title = "Please check all fills again."
                        alert.message = ""
                        alert.addButtonWithTitle("Ok")
                        alert.show()

                        print(error)
                    } else {
                        // Email changed successfully
                        var savePasswordAlert = UIAlertController(title: "Successfully updated.", message: "Please login with your new email.", preferredStyle: UIAlertControllerStyle.Alert)
                        savePasswordAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                            self.performSegueWithIdentifier("saveEmail", sender: self)
                        }))
                        
                        self.presentViewController(savePasswordAlert, animated: true, completion: nil)
                        
                    }
            })
        } else {
            var savePasswordAlert = UIAlertController(title: "Error.", message: "Emails do not match. Please check again.", preferredStyle: UIAlertControllerStyle.Alert)
            savePasswordAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            self.presentViewController(savePasswordAlert, animated: true, completion: nil)
        }
        
    }

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
