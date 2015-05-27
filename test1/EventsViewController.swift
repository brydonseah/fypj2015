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

    var updatedName: String!
    var updatedDate: String!
    var uniqKey: String!
    
    var event: Event!
    var eventUpdate: Event!
    var currentCell: EventTableViewCell!
    
    var dateFormatter = NSDateFormatter()
    var eventDate = NSDate()
    var indexOfObject: Int!
    var e1: Event!
    var ref = Firebase(url: "https://quest2015.firebaseio.com/activities")
    
    var userEmail: String!
    var userPass: String!
    var cellColor : UIColor = UIColor(red: (238/255.0), green: (232/255.0), blue: (170/255.0), alpha: 0.8)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        //        self.events = self.retrieveDataIntoArray()
        ref.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let name = snapshot.value["name"] as! String
            let datetime = snapshot.value["datetime"] as! String
            let code = snapshot.value["code"] as! String
            let uniqKey = snapshot.key as String
            
            var e = Event()
            e.uniqueKey = uniqKey
            e.title = name
            e.date = datetime
            e.code = code
            
            self.dataArray.append(e)
            self.tableView.reloadData()
            println(name)
              self.tableView.backgroundView = UIImageView(image: UIImage(named: "img3"))
            self.tableView.backgroundView!.alpha = 0.9
            
        })

        ref.queryOrderedByKey().observeEventType(.ChildChanged, withBlock: { snapshot in
            let name = snapshot.value["name"] as! String
            let datetime = snapshot.value["datetime"] as! String
            var e = self.dataArray[self.indexOfObject]
            e.title = name //self.updatedName
            e.date =  datetime //self.updatedDate
            println("The updated name is \(name),\(datetime)")
            self.tableView.reloadData()
        })
        
        
        ref.queryOrderedByKey().observeEventType(.ChildRemoved, withBlock: { snapshot in
            let name = snapshot.value["name"] as! String
            let datetime = snapshot.value["datetime"] as! String
            println("The removed object name is \(name),\(datetime)")
            self.tableView.reloadData()
        })

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 121
      
        println(self.userEmail)
 
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
        //Return the number of rows in the section.
            return self.dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell
        
        cell.backgroundColor = cellColor
       let e = self.dataArray[indexPath.row] as Event
        cell.titleLabel.text = e.title
        cell.dateLabel.text = e.date
        
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
    
    @IBAction func cancelToEventsViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveEventDetail(segue:UIStoryboardSegue) {
        let eventDetailsViewController = segue.sourceViewController as! EventDetailsViewController
        //add the new event to the events array
        //events.append(eventDetailsViewController.e)
        
        //dataArray.append(eventDetailsViewController.e)
        
        //update the tableView
//        let indexPath = NSIndexPath(forRow:dataArray.count-1, inSection: 0)
//        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
       

//            let name = snapshot.value["name"] as! String
//            println(name)
//            let datetime = snapshot.value["datetime"] as! String
//            let code = snapshot.value["code"] as! String
//            let key = snapshot.key as String
//            
//            var e = Event()
//            e.uniqueKey = key
//            e.title = name
//            e.date = datetime
//            e.code = code
//            println("LoginView")
//            self.dataArray.append(e)
        

        
        //SQLite - Create
//        let filemgr = NSFileManager.defaultManager()
//        let dirPaths =
//        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
//            .UserDomainMask, true)
//        
//        let docsDir = dirPaths[0] as! String
//        
//        databasePath = docsDir.stringByAppendingPathComponent(
//            "fypj_2015.db")
//        
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB.open() {
//            
//            let insertSQL = "INSERT INTO EVENTS (name, datetime, code) VALUES ('\(eventDetailsViewController.eventTextField.text)', '\(eventDetailsViewController.datefield.text)',' \(code)')"
//            
//            let result = contactDB.executeUpdate(insertSQL,
//                withArgumentsInArray: nil)
//            
//            if !result {
//                println("failure")
//                println("Error: \(contactDB.lastErrorMessage())")
//            }
//            else {
//                println("added")
//                eventDetailsViewController.eventTextField.text = ""
//                eventDetailsViewController.datefield.text = ""
//                self.events = self.retrieveDataIntoArray()
//            }
//        } else {
//            
//            println("Error: \(contactDB.lastErrorMessage())")
//        }
    }
    
//    func retrieveDataIntoArray() -> [Event]{
//        
//        let filemgr = NSFileManager.defaultManager()
//        let dirPaths =
//        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
//            .UserDomainMask, true)
//        
//        let docsDir = dirPaths[0] as! String
//        
//        databasePath = docsDir.stringByAppendingPathComponent(
//            "fypj_2015.db")
//        
//        let contactDB = FMDatabase(path: databasePath as String)
//        var sqlArray : [Event] = []
//        
//        if contactDB.open() {
//            let querySQL = "SELECT * FROM EVENTS"
//            
//            let results:FMResultSet? = contactDB.executeQuery(querySQL,
//                withArgumentsInArray: nil)
//            
//            while results?.next() == true {
//                
//                var name:String! = results?.stringForColumn("name")
//                var datetime:String! = results?.stringForColumn("datetime")
//                var idNum:String! = results?.stringForColumn("ID")
//                var codeNum:String! = results?.stringForColumn("Code")
//                id = idNum
//                code = codeNum
//                //println(idNum)
//                var event = Event()
//                event.title = name
//                event.date = datetime
//                event.id = idNum
//                event.code = codeNum as String!
//                sqlArray.append(event)
//                println(sqlArray.count)
//            }
//            contactDB.close()
//            
//            return sqlArray
//        }
//        else {
//            println("Error: \(contactDB.lastErrorMessage())")
//        }
//        
//        return sqlArray
//    }
    
//    func retrieveUpdate() -> [Event]{
//        var temp: [Event] = []
//        var ref = Firebase(url: "https://fypjquest2015.firebaseio.com/activities")
//        ref.queryOrderedByKey().observeEventType(.Value, withBlock: {
//            snapshot in
//            if let i = snapshot.value as? NSDictionary {
//                for item in i{
//                    if let value = item.value as? NSDictionary {
//                        var e = Event()
//                        e.uniqueKey = item.key as! String
//                        e.title = value["name"] as! String
//                        e.date = value["datetime"] as! String
//                        e.code = value["code"] as! String
//                        self.dataArray.append(e)
////                        println(temp.count)
//                        
//                    }
//                }
//            }
//        })
//        return self.dataArray
//    }
    
    @IBAction func updateEventDetails(segue:UIStoryboardSegue){
        
        
        
        
        
      /*  dispatch_sync(dispatch_get_global_queue(
            Int(QOS_CLASS_USER_INTERACTIVE.value), 0)) {*/
//        let devc = segue.sourceViewController as! DetailsEventViewController
// 
//        var ref = Firebase(url: "https://fypjquest2015.firebaseio.com/activities")
        
        //Firebase - Update
        
//        var hopperRef = ref.childByAppendingPath("\(devc.event.uniqueKey)")
//        var updateValue = ["name": "\(updatedName)", "datetime": "\(updatedDate)"]
//        hopperRef.updateChildValues(updateValue)
        
        //        //SQLite - Update
        //        var eTitle = eventNameTextField.text
        //        var eDate = dateTimeTextField.text
        //        var eCode = self.event.code
        //
        //        let contactDB = FMDatabase(path: databasePath as String)
        //
        //        if contactDB.open() {
        //
        //            var updateSQL = "UPDATE EVENTS SET NAME ='" + eTitle + "', DATETIME ='" + eDate
        //            updateSQL += "' WHERE CODE = " + eCode
        //
        //            //println(eId.description)
        //            let result = contactDB.executeUpdate(updateSQL,
        //                withArgumentsInArray: nil)
        //
        //            if !result {
        //
        //                println("failure")
        //                println("Error: \(contactDB.lastErrorMessage())")
        //            }
        //        } else {
        //            
        //            println("Error: \(contactDB.lastErrorMessage())")
        //        }
//        self.performSegueWithIdentifier("UpdateEventDetail", sender: self) 
        //}
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
            var eventTitle = self.dataArray[indexPath.row].uniqueKey
            
            var ref = Firebase(url: "https://quest2015.firebaseio.com/activities")
            var hopperRef = ref.childByAppendingPath("\(eventTitle)")
            hopperRef.removeValue()
            
            
            // Delete the row from the data source
            self.dataArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)

            
//            let filemgr = NSFileManager.defaultManager()
//            let dirPaths =
//            NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
//                .UserDomainMask, true)
//            
//            let docsDir = dirPaths[0] as! String
//            
//            self.databasePath = docsDir.stringByAppendingPathComponent(
//                "fypj_2015.db")
//            
//            
//            let contactDB = FMDatabase(path: self.databasePath as String)
//            
//            if contactDB.open() {
//                
//                let deleteSQL = "DELETE FROM EVENTS WHERE name ='" + eventTitle + "'"
//                
//                let result = contactDB.executeUpdate(deleteSQL,
//                    withArgumentsInArray: nil)
//                
//                if !result {
//                    println("failure")
//                    println("Error: \(contactDB.lastErrorMessage())")
//                }
//                else {
//                    println("deleted")
//                }
//            }
//            else {
//                println("Error: \(contactDB.lastErrorMessage())")
//            }
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
            
            var e = self.dataArray[iPath.row]
            println(e.uniqueKey)
            devc.event = e
            devc.index = iPath.row
        }
        
    }
    
    
}
