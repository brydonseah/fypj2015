//
//  StudentDetailsTableViewController.swift
//  test1
//
//  Created by fypjadmin on 15/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentDetailsTableViewController: UITableViewController {
    
    
    @IBOutlet var categoryLabel: UILabel!
    var student:Student!
    var students: [Student] = []
    @IBOutlet var studNameTextField: UITextField!
    var category:String = "1A"
    var databasePath = NSString()
    var studentID = Int32()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        categoryLabel.text = category
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    @IBAction func saveStudentDetail(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func selectedCategory(segue:UIStoryboardSegue) {
        if let classPickerTableViewController = segue.sourceViewController as? ClassPickerTableViewController, selectedCategory = classPickerTableViewController.selectedCategory {
            
            categoryLabel.text = selectedCategory
            category = selectedCategory
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "SaveStudentDetail" {
            student = Student(studentID: 0, name: self.studNameTextField.text, category: category)
            
        
        if segue.identifier == "PickCategory" {
            
            if let classPickerTableViewController = segue.destinationViewController as? ClassPickerTableViewController{
                
                classPickerTableViewController.selectedCategory = category
            }
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            studNameTextField.becomeFirstResponder()
        }
    }
    
  

    


   /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("classCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel!.text = student.category
        
        return cell
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
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

}
