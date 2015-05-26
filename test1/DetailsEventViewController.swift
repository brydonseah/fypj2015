//
//  DetailsEventViewController.swift
//  test1
//
//  Created by fypjadmin on 10/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class DetailsEventViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var dateTimeTextField: UITextField!
    @IBOutlet var eventNameTextField: UITextField!
    
    @IBOutlet var codeLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    var event: Event!
    var databasePath = NSString()
    var idNum: Int32!
    var datePickerView:UIDatePicker!
    var inputDateView:UIView!
    var code: String!
    var index: Int!
    var studArray: [Student] = []
    
    var ref = Firebase(url: "https://quest2015.firebaseio.com/studentActivity")
    
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
        codeLabel.text = event.code
        
       println(event.code)
//       println(event.title)
//       println(event.date)
        ref.queryOrderedByChild("code").queryEqualToValue(event.code).observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let name = snapshot.value["student"] as! String
            
            var s = Student()
            s.name = name

            self.studArray.append(s)
            self.tableView.reloadData()
            println(name)
            self.tableView.reloadData()
        })

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        //Return the number of rows in the section.
        return self.studArray.count
    }

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentECell", forIndexPath: indexPath) as! UITableViewCell
        
        let s = self.studArray[indexPath.row] as Student
        
        cell.textLabel?.text = s.name
        
        
        // Configure the cell...
        //        var cDate = NSDate()
        //        var formatDate = NSDateFormatter()
        //        formatDate.dateFormat = "dd-MM-yyyy hh:mm:aa"
        //        var eventDateDate = formatDate.dateFromString(e1.date)
        //
        //        if eventDateDate?.compare(cDate) == NSComparisonResult.OrderedDescending {
        //
        //            cell.titleLabel.textColor = UIColor.blackColor()
        //            //            println("Earlier")
        //        }
        //        else if eventDateDate?.compare(cDate) == NSComparisonResult.OrderedAscending {
        //
        //            cell.titleLabel.textColor = UIColor.redColor()
        //            //            println("OKAY")
        //        }
        return cell
    }

    
//    @IBAction func updateEventDetails(){
//        dispatch_sync(dispatch_get_global_queue(
//            Int(QOS_CLASS_USER_INTERACTIVE.value), 0)) {
//        //Firebase - Update
//        var ref = Firebase(url: "https://fypjquest2015.firebaseio.com/activities")
//        var hopperRef = ref.childByAppendingPath("\(self.event.uniqueKey)")
//        var updateValue = ["name": "\(self.eventNameTextField.text)", "datetime": "\(self.dateTimeTextField.text)"]
//        hopperRef.updateChildValues(updateValue)
//        
////        println(hopperRef)
////        println(updateValue)
//        
//        println("help me")
//        /*ref.observeEventType(.ChildChanged, withBlock: { snapshot in
//            
//            let name = snapshot.value["name"] as? String
//            println("The updated post title is \(name)")
//        })*/
//        }
//        var ref = Firebase(url: "https://fypjquest2015.firebaseio.com/activities")
//        ref.observeEventType(.ChildChanged, withBlock: { snapshot in
//            let name = snapshot.value["name"] as! String
//            println("The updated post title is \(name)")
//            }, withCancelBlock: { error in
//                println(error.description)
//        })
//
//        
//        println("come on")
//        
////        //SQLite - Update
////        var eTitle = eventNameTextField.text
////        var eDate = dateTimeTextField.text
////        var eCode = self.event.code
////        
////        let contactDB = FMDatabase(path: databasePath as String)
////        
////        if contactDB.open() {
////            
////            var updateSQL = "UPDATE EVENTS SET NAME ='" + eTitle + "', DATETIME ='" + eDate
////            updateSQL += "' WHERE CODE = " + eCode
////            
////            //println(eId.description)
////            let result = contactDB.executeUpdate(updateSQL,
////                withArgumentsInArray: nil)
////            
////            if !result {
////                
////                println("failure")
////                println("Error: \(contactDB.lastErrorMessage())")
////            }
////        } else {
////            
////            println("Error: \(contactDB.lastErrorMessage())")
////        }
//        self.performSegueWithIdentifier("UpdateEventDetail", sender: self)
//    }
    
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
        //println("done button done")
        dateChanged(datePickerView)
        dateTimeTextField.resignFirstResponder()
    }

    
    
      // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpdateEventDetail" {
            var vc = segue.destinationViewController as! EventsViewController
            vc.eventUpdate = event
            vc.updatedName = self.eventNameTextField.text
            vc.updatedDate = self.dateTimeTextField.text
            vc.indexOfObject = self.index
            
            var ref = Firebase(url: "https://quest2015.firebaseio.com/activities")
            var hopperRef = ref.childByAppendingPath("\(event.uniqueKey)")
            var updateValue = ["name": "\(self.eventNameTextField.text)", "datetime": "\(self.dateTimeTextField.text)"]
            hopperRef.updateChildValues(updateValue)
            
            eventNameTextField.text = ""
            dateTimeTextField.text = "" 
        }
        
    }
    
}
