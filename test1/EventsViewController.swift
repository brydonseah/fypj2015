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
    var dataArray: [Event] = []
    var databasePath = NSString()
    var id =  String()
    var code = String()
    var nameEvent = String()
    var dateEvent = String()
    var event: Event!
    var eventUpdate: Event!
    var currentCell: EventTableViewCell!
    
    var dateFormatter = NSDateFormatter()
    var eventDate = NSDate()
    var myArray: [NSDictionary] = []
    
    
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
        
        let docsDir = dirPaths[0] as! String
        let contactDB = FMDatabase(path: databasePath as String)
        
        databasePath = docsDir.stringByAppendingPathComponent(
            "fypj_2015.db")
        
//        self.events = self.retrieveDataIntoArray()
        self.tableView.rowHeight = 121
        self.tableView.backgroundView!.alpha = 0.3 // = UIColor.blackColor().colorWithAlphaComponent(0.3)
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "projimg"))
        println("hahaha")
        self.tableView.reloadData()

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
        return self.dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("hello")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell
  
        self.event = self.dataArray[indexPath.row] as Event
        
        println(event.title)
        cell.titleLabel.text = event.title
        cell.dateLabel.text = event.date
        
//        self.cellForRowAtIndexPath(indexPath)

        // Configure the cell...
    
        var cDate = NSDate()
        var formatDate = NSDateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy hh:mm:aa"
        var eventDateDate = formatDate.dateFromString(event.date)
        
        if eventDateDate?.compare(cDate) == NSComparisonResult.OrderedDescending {
        
            cell.titleLabel.textColor = UIColor.redColor()
            println("Earlier")
        }
        else if eventDateDate?.compare(cDate) == NSComparisonResult.OrderedAscending {
            
            cell.titleLabel.textColor = UIColor.purpleColor()
            println("OKAY")
        }
//        let cell = self.cellForRowAtIndexPath(self.myArray, indexPath: indexPath)
        return cell
    }
    
//    func cellForRowAtIndexPath(dataA: [NSDictionary], indexPath: NSIndexPath) -> UITableViewCell?{
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell
//        if (dataA.count < 1){
//            return nil
//        } else {
//            let object: NSDictionary = dataA[0]
//            println(object["name"])
//            cell.titleLabel.text = object["name"] as? String
//            cell.dateLabel.text = object["datetime"] as? String
//        return cell
//        }
//    }
    
//    func register() {
//        var ref = Firebase(url: "https://fypjquest2015.firebaseio.com/activities")
//        ref.observeEventType(.Value, withBlock: {
//            snapshot in
//            if let i = snapshot.value as? NSDictionary {
//                for item in i{
//                    if let value = item.value as? NSDictionary {
//                        var e = Event()
//                        e.title = value["name"] as! String
//                        e.date = value["datetime"] as! String
//                        e.code = value["code"] as! String
//                        self.events.append(e)
//                        println(e.title)
//                        println(self.events.count)
//                    }
//                }
//            }
//        })
//    }
    
    @IBAction func unwindEventDetail(segue:UIStoryboardSegue){
        
        self.events = self.retrieveDataIntoArray()
        //hide the detail view controller
        dismissViewControllerAnimated(true, completion: nil)
        
        self.tableView.reloadData()
    }
    
    @IBAction func cancelToEventsViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveEventDetail(segue:UIStoryboardSegue) {
        
        let eventDetailsViewController = segue.sourceViewController as! EventDetailsViewController
        
        var ref = Firebase(url: "https://fypjquest2015.firebaseio.com/")
        let postRef = ref.childByAppendingPath("activities")
        let post1 = ["name": "\(eventDetailsViewController.eventTextField.text)", "datetime": "\(eventDetailsViewController.datefield.text)", "code": "\(code)"]
        let post1Ref = postRef.childByAutoId()
        post1Ref.setValue(post1)

        //add the new event to the events array
        events.append(eventDetailsViewController.e)
        
        //update the tableView
        let indexPath = NSIndexPath(forRow: events.count-1, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        
        //hide the detail view controller
        dismissViewControllerAnimated(true, completion: nil)
        
            code = String(arc4random_uniform(9999))
        
            let contactDB = FMDatabase(path: databasePath as String)
            
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
        let contactDB = FMDatabase(path: databasePath as String)
        var dataArray : [Event] = []
        
        if contactDB.open() {
            let querySQL = "SELECT * FROM EVENTS"
            
            let results:FMResultSet? = contactDB.executeQuery(querySQL,
                withArgumentsInArray: nil)
            
            while results?.next() == true {
                
                var name:String! = results?.stringForColumn("name")
                var datetime:String! = results?.stringForColumn("datetime")
                var idNum:String! = results?.stringForColumn("ID")
                var codeNum:String! = results?.stringForColumn("Code")
                id = idNum
                code = codeNum
                //println(idNum)
                var event = Event()
                event.title = name
                event.date = datetime
                event.id = idNum
                event.code = codeNum as String!
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
            let contactDB = FMDatabase(path: self.databasePath as String)
            
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
            
            var iPath: NSIndexPath = sender as! NSIndexPath
            // initialize new view controller and cast it as your view controller
            var devc = segue.destinationViewController as! DetailsEventViewController
            // your new view controller should have property that will store passed value
            
            var e = self.events[iPath.row]
            devc.event = e
        }
       
    }


}
