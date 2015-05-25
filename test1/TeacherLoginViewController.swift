//
//  TeacherLoginViewController.swift
//  test1
//
//  Created by fypjadmin on 18/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class TeacherLoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    var firstPass: String!
    var ref = Firebase(url: "https://quest2015.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.emailTextField.text = "brydon@gmail.com"
        self.passTextField.text = "12345"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveSignUp(segue: UIStoryboardSegue){
    }
    
    @IBAction func login(){
        
        ref.authUser("\(self.emailTextField.text)", password: "\(self.passTextField.text)") {
            error, authData in
            if (error != nil) {
                // an error occurred while attempting login
                if let errorCode = FAuthenticationError(rawValue: error.code) {
                    switch (errorCode) {
                    case .UserDoesNotExist:
                        let alert = UIAlertView()
                        alert.title = "Error Logging In"
                        alert.message = "User does not exist. Please check again."
                        alert.addButtonWithTitle("Ok")
                        alert.show()
                    case .InvalidEmail:
                        let alert = UIAlertView()
                        alert.title = "Error Logging In"
                        alert.message = "Invalid Email/Password. Please check again."
                        alert.addButtonWithTitle("Ok")
                        alert.show()
                    case .InvalidPassword:
                        let alert = UIAlertView()
                        alert.title = "Error Logging In"
                        alert.message = "Invalid Email/Password. Please check again."
                        alert.addButtonWithTitle("Ok")
                        alert.show()
                    default:
                        println("Handle default situation")
                    }
                }
            } else {
                // User is logged in
                println(authData.uid)
                
                let newUser = [ "password": authData.provider,
                    "email": authData.providerData["email"] as? NSString as? String]
                
                self.ref.childByAppendingPath("users")
                    .childByAppendingPath(authData.uid).setValue(newUser)
                
                // We are now logged in
                var loginSuccess = UIAlertController(title: "Login succesfully.", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                loginSuccess.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    self.performSegueWithIdentifier("LoginSuccess", sender: self)
                }))
                
                self.presentViewController(loginSuccess, animated: true, completion: nil)

            }
        }
        
    }
    
    @IBAction func forgotPass(segue: UIStoryboardSegue){
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "LoginSuccess"){
            let tab: UITabBarController = segue.destinationViewController as! UITabBarController
            let nav: UINavigationController = tab.viewControllers?.first as! UINavigationController
            let evc: EventsViewController = nav.viewControllers?.first as! EventsViewController

            
            evc.userEmail = self.emailTextField.text
            evc.userPass = self.passTextField.text
            
        }
    }
    

}
