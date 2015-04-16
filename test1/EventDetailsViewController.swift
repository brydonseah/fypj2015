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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
            event = Event(title: self.eventTextField.text, date: self.datefield.text, id: 0, code: 0)
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


