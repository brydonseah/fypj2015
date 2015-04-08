//
//  EventsDetailViewController.swift
//  test1
//
//  Created by fypjadmin on 27/3/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class EventDetailsViewController: UITableViewController {
    @IBOutlet weak var eventTextField: UITextField!
    var event:Event!
    var datePickerView:UIDatePicker!
    @IBOutlet weak var datefield: UITextField!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!

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
            event = Event(title: self.eventTextField.text, date: self.datefield.text)
        }
    }
    
    @IBAction func textFieldEditing(sender: UITextField) {
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        
        var datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(240, 40, 0, 0))
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let buttonDone = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        buttonDone.setTitle("Done", forState: UIControlState.Normal)
        buttonDone.setTitle("Done", forState: UIControlState.Highlighted)
        buttonDone.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        buttonDone.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(buttonDone) // add Button to UIView
        
        buttonDone.addTarget(self, action: Selector("finishDone:"), forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: Selector("dateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
           }
    
    func dateChanged(sender: UIDatePicker) {
        var formatDate = NSDateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy hh:mm:aa"
        datefield.text = formatDate.stringFromDate(sender.date)
    }
    
//    func finishDone(sender:UIButton)
//    {
//        datePickerView.resignFirstResponder() // To resign the inputView on clicking done.
//    }
//    
    }


