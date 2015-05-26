//
//  StudentEventCheckInViewController.swift
//  test1
//
//  Created by Eugene Tan on 26/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentEventCheckInViewController: UIViewController {

    @IBOutlet var eventNameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    
    @IBOutlet var submitButton: UIButton!
    
    var e: Event!
    var stud: Student!
    var count: Int = 1
    var studName: [String] = []
    var code: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventNameTextField.text = e.title
        dateTextField.text = e.date
        code = e.code
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButton(sender: UIButton) {
        
        if (self.codeTextField.text == code){
        self.studName.append(stud.name)
        var studString = ""
        for (var i = 0; i < self.studName.count; i++) {
        
            if (i == 0) {
                
                studString = self.studName[i]
                
            } else if (i != 0){
                
                studString = studString + ", " + self.studName[i]
            }
        }
        
        var ref = Firebase(url: "https://quest2015.firebaseio.com/activities")
        var hopperRef = ref.childByAppendingPath("\(e.uniqueKey)")
        var updateValue = ["student": "\(studString)"]
        hopperRef.updateChildValues(updateValue)
        
        
        var submitAlert = UIAlertController(title: "Successfully checked in.", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        submitAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.performSegueWithIdentifier("unwindCheckIn", sender: self)
        }))
        self.presentViewController(submitAlert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertView()
            alert.title = "Error checking in!"
            alert.message = "Wrong code entered. Please check again."
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "unwindCheckIn"){
                        
        }
        
    }
    

}
