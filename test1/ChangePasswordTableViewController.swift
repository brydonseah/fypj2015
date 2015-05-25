//
//  ChangePasswordTableViewController.swift
//  test1
//
//  Created by Eugene Tan on 25/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class ChangePasswordTableViewController: UITableViewController {
    @IBOutlet var currentPassTextField: UITextField!
    @IBOutlet var newPassTextField: UITextField!
    @IBOutlet var confirmPassTextField: UITextField!
    
    var ref = Firebase(url: "https://quest2015.firebaseio.com/")
    var getUserRef = Firebase(url: "https://quest2015.firebaseio.com/users")
    var userEmail: String!
    
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
            
            self.userEmail = userEmail
            
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePassword(sender: UIBarButtonItem){
        if (newPassTextField.text == confirmPassTextField.text){
            ref.changePasswordForUser("\(userEmail)", fromOld: "\(currentPassTextField.text)",
                toNew: "\(confirmPassTextField.text)", withCompletionBlock: { error in
                    if error != nil {
                        // There was an error processing the request
                        let alert = UIAlertView()
                        alert.title = "Please check all fills again."
                        alert.message = ""
                        alert.addButtonWithTitle("Ok")
                        alert.show()
                    } else {
                        // Password changed successfully
                        var savePasswordAlert = UIAlertController(title: "Successfully updated.", message: "Please login with your new password.", preferredStyle: UIAlertControllerStyle.Alert)
                        savePasswordAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                            self.performSegueWithIdentifier("savePassword", sender: self)
                        }))
                    
                        self.presentViewController(savePasswordAlert, animated: true, completion: nil)

                    }
            })
        } else {
            var savePasswordAlert = UIAlertController(title: "Error.", message: "Passwords do not match. Please check again.", preferredStyle: UIAlertControllerStyle.Alert)
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
