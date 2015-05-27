//
//  StudentDetailsTableViewController.swift
//  test1
//
//  Created by fypjadmin on 15/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentDetailsTableViewController: UITableViewController {
    
    
    @IBOutlet var studNameTextField: UITextField!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    var student:Student!
    var students: [Student] = []
    
    var category:String = "1A"
    var databasePath = NSString()
    var studentID = Int32()
    var gender:String = "M"
    @IBOutlet var studentImage: UIImageView!
    var ref = Firebase(url: "https://quest2015.firebaseio.com/")
    var s: Student!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        genderLabel.text = gender
        categoryLabel.text = category
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.studentImage.alpha = 0.9 // = UIColor.blackColor().colorWithAlphaComponent(0.3)
        self.studentImage.image = UIImage(named:"img3")

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveStudentDetail(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func selectedGender(segue:UIStoryboardSegue) {
        if let genderPickerTableViewController = segue.sourceViewController as? GenderPickerTableViewController, selectedGender = genderPickerTableViewController.selectedGender {
            
            genderLabel.text = selectedGender
            gender = selectedGender
        }
    }

    
    @IBAction func selectedCategory(segue:UIStoryboardSegue) {
        if let classPickerTableViewController = segue.sourceViewController as? ClassPickerTableViewController, selectedCategory = classPickerTableViewController.selectedCategory {
            
            categoryLabel.text = selectedCategory
            category = selectedCategory
        }
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "SaveStudentDetail" {
            
            println(self.studNameTextField.text)
            var name = studNameTextField.text
            
            var s = Student()
            s.name = name
            s.gender = gender
            s.category = category
            
            let postRef = ref.childByAppendingPath("students")
            let post1 = ["name": "\(studNameTextField.text)", "gender": "\(gender)", "class": "\(category)"]
            let post1Ref = postRef.childByAutoId()
            //        println(post1Ref)
            post1Ref.setValue(post1)

            
            if segue.identifier == "PickGender" {
                if let genderPickerTableViewController = segue.destinationViewController as?
                    GenderPickerTableViewController{
                        genderPickerTableViewController.selectedGender = gender
                }
            }

        
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
