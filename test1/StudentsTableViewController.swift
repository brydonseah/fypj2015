//
//  StudentsTableViewController.swift
//  test1
//
//  Created by fypjadmin on 14/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate{
    
    @IBOutlet var searchBar: UISearchBar!
    
    //var searchController : UISearchController!
    //var searchResultsController : UITableViewController!
    //var searchResultsUpdater: UISearchResultsUpdating?
    var students: [Student] = []
    var student: Student!
    var studentID = Int32()
    var name = String()
    var filteredStudents = [Student]()
    var studentUpdate: Student!
    var databasePath = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let resultsTableView = UITableView(frame: self.tableView.frame)
        //searchResultsController = UITableViewController()
        //searchResultsController?.tableView = resultsTableView
        //searchResultsController?.tableView.dataSource = self;
        //searchResultsController?.tableView.delegate = self
        //searchController = UISearchController(searchResultsController: searchResultsController!)
        //searchController.searchResultsUpdater = searchResultsUpdater
       // searchController?.delegate = self
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
        let contactDB = FMDatabase(path: databasePath as String)
        
        databasePath = docsDir.stringByAppendingPathComponent(
            "fypj_2015")
        
        self.students = self.retrieveStudent()
        self.tableView.rowHeight = 100
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        
                
        
       

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
            return students.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // ask for reusable cell from the tableview, the tableview will create a new one if it doesnt have any
        let cell = self.tableView.dequeueReusableCellWithIdentifier("StudentCell") as! UITableViewCell
        
        //configure the cell
        self.student = self.students[indexPath.row] as Student
        cell.textLabel!.text = student.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    @IBAction func unwindStudentDetails(segue:UIStoryboardSegue){
        
        self.students = self.retrieveStudent()
        //hide the detail view controller
        dismissViewControllerAnimated(true, completion: nil)
        
        self.tableView.reloadData()
    }

    
    @IBAction func cancelToStudentsTableViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveStudentDetail(segue:UIStoryboardSegue) {
        let studentDetailsTableViewController = segue.sourceViewController as! StudentDetailsTableViewController
        
        //add the new event to the events array
        students.append(studentDetailsTableViewController.student)
        
        //update the tableView
        let indexPath = NSIndexPath(forRow: students.count-1, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        
        //hide the detail view controller
        dismissViewControllerAnimated(true, completion: nil)
        
        
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB.open() {
            
            let insertSQL = "INSERT INTO STUDENT (name, category) VALUES ('\(studentDetailsTableViewController.studNameTextField.text)', '\(studentDetailsTableViewController.category)')"
            
            let result = contactDB.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
                println("failure")
                println("Error: \(contactDB.lastErrorMessage())")
            }
            else {
                println("added")
                studentDetailsTableViewController.studNameTextField.text = ""
                studentDetailsTableViewController.category = ""
                self.students = self.retrieveStudent()
            }
        } else {
            
            println("Error: \(contactDB.lastErrorMessage())")
            
            
        }
    }
    


    
    func retrieveStudent() -> [Student]{
     
        let contactDB = FMDatabase(path: databasePath as String)
        var studentDataArray : [Student] = []
        
        if contactDB.open() {
            let querySQL = "SELECT * FROM STUDENT"
            
            let results:FMResultSet? = contactDB.executeQuery(querySQL,
                withArgumentsInArray: nil)
            
            while results?.next() == true {
                
                var studID : Int32! = results?.intForColumn("studentID")
                var name : String! = results?.stringForColumn("name")
                var category : String! = results?.stringForColumn("category")
                
                studentID = studID
                
                var student = Student(studentID: studID, name: name, category: category)
                studentDataArray.append(student)

            }
            contactDB.close()
            
            return studentDataArray
        }
        else {
            
            println("Error: \(contactDB.lastErrorMessage())")
        }
        return studentDataArray
    }
    
    
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
            var studentName = self.students[indexPath.row].name
            
            // Delete the row from the data source
            self.students.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            let contactDB = FMDatabase(path: self.databasePath as String)
            
            if contactDB.open() {
                
                let deleteSQL = "DELETE FROM STUDENT WHERE name ='" + studentName + "'"
                
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
            
            var s = self.students[iPath.row]
            devc.student = s
        }
        
    }




    
  /*
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
            self.filteredStudents = self.students.filter({(student: Student) -> Bool in
            let categoryMatch = (scope == "All") || (student.category == scope)
            let stringMatch = student.name.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
        })
    }
*/
    
    /*
func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchBarText = self.searchController!.searchBar.text
        
        let predicate = NSPredicate(block: { (city: AnyObject!, b: [NSObject : AnyObject]!) -> Bool in
        
        var range: NSRange = 0, self.filteredStudents.count
        
        if city is NSString {
            range = city.rangeOfString(searchBarText, options: NSStringCompareOptions.CaseInsensitiveSearch)
        }
            
        return range.location != NSNotFound
        })
    }
*/
    
   
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
