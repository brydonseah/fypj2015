//
//  DetailsEventViewController.swift
//  test1
//
//  Created by fypjadmin on 10/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class DetailsEventViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var dateTimeTextField: UITextField!
    @IBOutlet var eventNameTextField: UITextField!
    
    
    var event: Event!
    var databasePath = NSString()
    var idNum: Int32!
    var datePickerView:UIDatePicker!
    var inputDateView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
        let contactDB = FMDatabase(path: databasePath as String)
        
        databasePath = docsDir.stringByAppendingPathComponent(
            "fypj_2015.db")

       eventNameTextField.text = event.title
       dateTimeTextField.text = event.date
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateEventDetails(){
        
        //println("method called")
        var eTitle = eventNameTextField.text
        var eDate = dateTimeTextField.text
        var eId = self.event.id
        
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB.open() {
            
            var updateSQL = "UPDATE EVENTS SET NAME ='" + eTitle + "', DATETIME ='" + eDate
            updateSQL += "' WHERE ID = " + eId
            
            //println(eId.description)
            let result = contactDB.executeUpdate(updateSQL,
                withArgumentsInArray: nil)
            
            if !result {
                println("failure")
                println("Error: \(contactDB.lastErrorMessage())")
            }
        } else {
            
            println("Error: \(contactDB.lastErrorMessage())")
        }
        self.performSegueWithIdentifier("UpdateEventDetail", sender: self)
    }
    
    @IBAction func textFieldEditing(sender: UITextField) {
        
        inputDateView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        datePickerView = UIDatePicker(frame: CGRectMake(160, 40, 0, 0))
        inputDateView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputDateView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputDateView
        
    }
    
    func dateChanged(sender: UIDatePicker) {
        var formatDate = NSDateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy hh:mm:aa"
        dateTimeTextField.text = formatDate.stringFromDate(sender.date)
    }
    
    func doneButton(sender:UIButton!)
    {
        println("done button done")
        dateChanged(datePickerView)
        dateTimeTextField.resignFirstResponder()
    }

    
    
      // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpdateEventDetail" {
            var vc = segue.destinationViewController as! EventsViewController
            vc.eventUpdate = event
            eventNameTextField.text = ""
            dateTimeTextField.text = "" 
        }
        
            
        
    }
    
    
    
    
    
    

}
