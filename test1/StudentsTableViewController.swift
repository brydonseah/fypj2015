//
//  StudentsTableViewController.swift
//  test1
//
//  Created by fypjadmin on 14/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController{


    var students: [Student] = []
    var studentDataArray: [Student] = []
    var filteredName: [String] = []
    var student: Student!
    var studentID: String!
    var name = String()
    var studentUpdate: Student!
    var databasePath = NSString()
    var maleColor : UIColor = UIColor(red: (173/255.0), green: (255/255.0), blue: (47/255.0), alpha: 0.5)
    var femaleColor : UIColor = UIColor(red: (238/255.0), green: (232/255.0), blue: (170/255.0), alpha: 0.5)
    
    var ref = Firebase(url: "https://quest2015.firebaseio.com/students")
    var dataArray: [Student] = []
    var indexOfObject: Int!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let name = snapshot.value["name"] as! String
            let gender = snapshot.value["gender"] as! String
            let studClass = snapshot.value["class"] as! String
            let uniqKey = snapshot.key as String
            
            var s = Student()
            s.name = name
            s.gender = gender
            s.category = studClass
            s.studentID = uniqKey
            
            self.dataArray.append(s)
            self.tableView.reloadData()
            println(name)
            
        })
        
        ref.queryOrderedByKey().observeEventType(.ChildChanged, withBlock: { snapshot in
            let name = snapshot.value["name"] as! String
            let studClass = snapshot.value["datetime"] as! String
            let gender = snapshot.value["gender"] as! String
            var s = self.dataArray[self.indexOfObject]
            s.name = name
            s.gender = gender
            s.category = studClass
            println("The updated name is \(name),\(studClass)")
            self.tableView.reloadData()
        })
        
        
        ref.queryOrderedByKey().observeEventType(.ChildRemoved, withBlock: { snapshot in
            let name = snapshot.value["name"] as! String
            let gender = snapshot.value["gender"] as! String
            let studClass = snapshot.value["class"] as! String
            println("The removed object name is \(name),\(gender), \(studClass)")
            self.tableView.reloadData()
        })
        
//        let filemgr = NSFileManager.defaultManager()
//        let dirPaths =
//        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
//            .UserDomainMask, true)
//        
//        let docsDir = dirPaths[0] as! String
//        let contactDB = FMDatabase(path: databasePath as String)
//        
//        databasePath = docsDir.stringByAppendingPathComponent(
//            "fypj_2015.db")
//        
//        self.students = self.retrieveStudent()
        
        self.tableView.rowHeight = 100
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "img3"))
        self.tableView.backgroundView!.alpha = 0.9 // = UIColor.blackColor().colorWithAlphaComponent(0.3)
       // retrieveStudent()
  
    }
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
       return self.dataArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // ask for reusable cell from the tableview, the tableview will create a new one if it doesnt have any
        let cell = self.tableView.dequeueReusableCellWithIdentifier("StudentCell", forIndexPath: indexPath) as! StudentCellViewCell
        
        
       // cell.backgroundColor!.alpha = 0.5
        let s = self.dataArray[indexPath.row] as Student
        cell.studentLabel.text = s.name
        
        
        if s.gender == "M" {
        
            cell.studentImage.image = UIImage(named: "Male")
            cell.backgroundColor = maleColor

            
        }
        else if s.gender == "F" {
            
            cell.studentImage.image = UIImage(named: "Female")
            cell.backgroundColor = femaleColor

        }
        
//        cell.studentLabel.text = s.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
             
        return cell
    }
    
    @IBAction func unwindStudentDetails(segue:UIStoryboardSegue){
        
        //self.students = self.retrieveStudent()
//        self.tableView.reloadData()
    }


    
    @IBAction func cancelToStudentsTableViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveStudentDetail(segue:UIStoryboardSegue) {
//        let studentDetailsTableViewController = segue.sourceViewController as! StudentDetailsTableViewController
//        
//        //add the new event to the events array
//        students.append(studentDetailsTableViewController.student)
//        
//        //update the tableView
//        let indexPath = NSIndexPath(forRow: students.count-1, inSection: 0)
//        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//        
//        
//        let contactDB = FMDatabase(path: databasePath as String)
//        
//        if contactDB.open() {
//            
//            let insertSQL = "INSERT INTO STUDENT (name,gender,category) VALUES ('\(studentDetailsTableViewController.studNameTextField.text)', '\(studentDetailsTableViewController.gender)', '\(studentDetailsTableViewController.category)')"
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
//                studentDetailsTableViewController.studNameTextField.text = ""
//                studentDetailsTableViewController.gender = ""
//                studentDetailsTableViewController.category = ""
//                self.students = self.retrieveStudent()
//            }
//        } else {
//            
//            println("Error: \(contactDB.lastErrorMessage())")
//            
//            
//        }
    }
    
//    func retrieveStudent() -> [Student]{
//     
//        let contactDB = FMDatabase(path: databasePath as String)
//        var studentDataArray : [Student] = []
//        
//        if contactDB.open() {
//            let querySQL = "SELECT * FROM STUDENT"
//            
//            let results:FMResultSet? = contactDB.executeQuery(querySQL,
//                withArgumentsInArray: nil)
//            
//            while results?.next() == true {
//                
//                var studID : Int32! = results?.intForColumn("studentID")
//                var gender:String! = results?.stringForColumn("gender")
//                var name : String! = results?.stringForColumn("name")
//                var category : String! = results?.stringForColumn("category")
//                
//                studentID = studID
//                
//                
//                var student = Student(studentID: studID, gender: gender, name: name, category: category)
//
//                studentDataArray.append(student)
//                println(studentDataArray.count)
//                
//
//            }
//            contactDB.close()
//            
//            return studentDataArray
//        }
//        else {
//            
//            println("Error: \(contactDB.lastErrorMessage())")
//        }
//        return studentDataArray
//    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    
   override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        //        var editAction = UITableViewRowAction(style: .Normal, title: "Edit") { (action, indexPath)  -> Void in
        //            tableView.editing = false
        //            self.performSegueWithIdentifier("EventDetails", sender: indexPath)
        //        }
        //        editAction.backgroundColor = UIColor.grayColor()
        
        var dAction  = UITableViewRowAction(style: .Normal,title: "Delete") { (action, indexPath)  -> Void in
            tableView.editing = false
            var studentName = self.dataArray[indexPath.row].studentID
            
            var ref1 = Firebase(url: "https://quest2015.firebaseio.com/students")
            var hopperRef = ref1.childByAppendingPath("\(studentName)")
            hopperRef.removeValue()
            
             //Delete the row from the data source
            self.dataArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            // let contactDB = FMDatabase(path: self.databasePath as String)
            
            //if contactDB.open() {
                
              //  let deleteSQL = "DELETE FROM STUDENT WHERE name ='" + studentName + "'"
                
               // let result = contactDB.executeUpdate(deleteSQL,
                 //   withArgumentsInArray: nil)
                
                //if !result {
               //     println("failure")
                //    println("Error: \(contactDB.lastErrorMessage())")
               // }
              //  else {
              //      println("deleted")
              //  }
           // }
            //else {
             //   println("Error: \(contactDB.lastErrorMessage())")
           // }
        }
        dAction.backgroundColor = UIColor.redColor()
        return [dAction]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        performSegueWithIdentifier("StudentDetails", sender: indexPath)
    }
    
        // MARK: - Table view data source
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        
        if (segue.identifier == "StudentDetails") {
            
            var iPath: NSIndexPath = sender as! NSIndexPath
            // initialize new view controller and cast it as your view controller
            var devc = segue.destinationViewController as! UpdateStudentsViewController
            // your new view controller should have property that will store passed value
            
            var s = self.dataArray[iPath.row]
            devc.student = s
        }
        
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */
    

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

   
}
}