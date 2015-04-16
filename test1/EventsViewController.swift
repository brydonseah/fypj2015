//
//  EventsViewController.swift
//  test1
//
//  Created by fypjadmin on 23/3/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class EventsViewController: UITableViewController {

    
    var events: [Event] = []
    var databasePath = NSString()
    var id =  Int32()
    var nameEvent = String()
    var dateEvent = String()
    var event: Event!
    var eventUpdate: Event!
    var currentCell: EventTableViewCell!
    var code = Int32()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         // self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as String
        let contactDB = FMDatabase(path: databasePath)
        
        databasePath = docsDir.stringByAppendingPathComponent(
            "fypj_2015")
        
        self.events = self.retrieveDataIntoArray()
        self.tableView.rowHeight = 121
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as EventTableViewCell
        self.event = self.events[indexPath.row] as Event
        cell.titleLabel.text = event.title
        cell.dateLabel.text = event.date
        
//        if(indexPath.row % 2 == 0){
//            cell.backgroundColor = UIColor.clearColor()
//        } else {
//            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
//            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
//            cell.detailTextLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
//        }
        
        // Configure the cell...

        return cell
    }
    
    @IBAction func unwindEventDetail(segue:UIStoryboardSegue){
        
        self.events = self.retrieveDataIntoArray()
        //hide the detail view controller
        dismissViewControllerAnimated(true, completion: nil)
        
        self.tableView.reloadData()
    }
    
    @IBAction func cancelToEventsViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveEventDetail(segue:UIStoryboardSegue) {
        let eventDetailsViewController = segue.sourceViewController as EventDetailsViewController
        
        //add the new event to the events array
        events.append(eventDetailsViewController.event)
        
        //update the tableView
        let indexPath = NSIndexPath(forRow: events.count-1, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        
        //hide the detail view controller
        dismissViewControllerAnimated(true, completion: nil)
        
            code = Int32(arc4random_uniform(9999))
        
            let contactDB = FMDatabase(path: databasePath)
            
            if contactDB.open() {
                
                let insertSQL = "INSERT INTO EVENTS (name, datetime, code) VALUES ('\(eventDetailsViewController.eventTextField.text)', '\(eventDetailsViewController.datefield.text)',' \(code)')"
                
                let result = contactDB.executeUpdate(insertSQL,
                    withArgumentsInArray: nil)
              
                if !result {
                    println("failure")
                    println("Error: \(contactDB.lastErrorMessage())")
                }
                else {
                    println("added")
                    eventDetailsViewController.eventTextField.text = ""
                    eventDetailsViewController.datefield.text = ""
                    self.events = self.retrieveDataIntoArray()
                }
            } else {
                
                println("Error: \(contactDB.lastErrorMessage())")
        }
    }
    
    func retrieveDataIntoArray() -> [Event]{
        let contactDB = FMDatabase(path: databasePath)
        var dataArray : [Event] = []
        
        if contactDB.open() {
            let querySQL = "SELECT * FROM EVENTS"
            
            let results:FMResultSet? = contactDB.executeQuery(querySQL,
                withArgumentsInArray: nil)
            
            while results?.next() == true {
                
                var name:String! = results?.stringForColumn("name")
                var datetime:String! = results?.stringForColumn("datetime")
                var idNum:Int32! = results?.intForColumn("ID")
                var codeNum:Int32! = results?.intForColumn("Code")
                id = idNum
                code = codeNum
                //println(idNum)
                var event = Event(title: name, date: datetime, id: idNum, code:codeNum)
                dataArray.append(event)
            }
            contactDB.close()
            
            return dataArray
        }
        else {
            println("Error: \(contactDB.lastErrorMessage())")
        }
        
        return dataArray
    }
    
    func compareDate() {
     
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        //self.performSegueWithIdentifier("EventDetails", sender: indexPath)
        performSegueWithIdentifier("EventDetails", sender: indexPath)
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
//        var editAction = UITableViewRowAction(style: .Normal, title: "Edit") { (action, indexPath)  -> Void in
//            tableView.editing = false
//            self.performSegueWithIdentifier("EventDetails", sender: indexPath)
//        }
//        editAction.backgroundColor = UIColor.grayColor()
        
        var dAction  = UITableViewRowAction(style: .Normal, title: "Delete") { (action, indexPath)  -> Void in
            tableView.editing = false
            var eventTitle = self.events[indexPath.row].title
            
            // Delete the row from the data source
            self.events.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            let contactDB = FMDatabase(path: self.databasePath)
            
            if contactDB.open() {
                
                let deleteSQL = "DELETE FROM EVENTS WHERE name ='" + eventTitle + "'"
                
                let result = contactDB.executeUpdate(deleteSQL,
                    withArgumentsInArray: nil)
                
                if !result {
                    println("failure")
                    println("Error: \(contactDB.lastErrorMessage())")
                }
                else {
                    println("deleted")
                }
            }
            else {
                println("Error: \(contactDB.lastErrorMessage())")
            }
        }
        dAction.backgroundColor = UIColor.redColor()
        return [dAction]
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        
        if (segue.identifier == "EventDetails") {
            
            var iPath: NSIndexPath = sender as NSIndexPath
            // initialize new view controller and cast it as your view controller
            var devc = segue.destinationViewController as DetailsEventViewController
            // your new view controller should have property that will store passed value
            
            var e = self.events[iPath.row]
            devc.event = e
        }
       
    }


}
