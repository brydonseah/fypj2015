//
//  EventsDetailViewController.swift
//  test1
//
//  Created by fypjadmin on 27/3/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class EventDetailsViewController: UITableViewController {
    @IBOutlet var eventTextField: UITextField!
    var event:Event!
    var datePickerView:UIDatePicker!
    var inputDateView:UIView!
    @IBOutlet var datefield: UITextField!
    var databasePath = NSString()
    var id =  Int32()
    var events: [Event] = []
    @IBOutlet var doneButton: UIBarButtonItem!
    var e = Event()
    var codeUniq: String!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.imageView.alpha = 0.9 // = UIColor.blackColor().colorWithAlphaComponent(0.3)
        self.imageView.image = UIImage(named:"img3")

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            eventTextField.becomeFirstResponder()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveEventDetail" {
            e.title = self.eventTextField.text
            e.date = self.datefield.text
            codeUniq = String(arc4random_uniform(9999))
            e.code = codeUniq
            //Firebase - Create
            var ref = Firebase(url: "https://quest2015.firebaseio.com/")
            let postRef = ref.childByAppendingPath("activities")
            let post1 = ["name": "\(eventTextField.text)", "datetime": "\(datefield.text)", "code": "\(codeUniq)"]
            let post1Ref = postRef.childByAutoId()
            //        println(post1Ref)
            post1Ref.setValue(post1)
            
            
        }
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
        datefield.text = formatDate.stringFromDate(sender.date)
    }
    
    func doneButton(sender:UIButton!)
    {
        println("done button done")
        dateChanged(datePickerView)
        datefield.resignFirstResponder()
        
    }
    
}


