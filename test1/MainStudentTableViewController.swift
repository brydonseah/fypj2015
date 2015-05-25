//
//  MainStudentTableViewController.swift
//  test1
//
//  Created by fypjadmin on 25/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class MainStudentTableViewController: UITableViewController {
    
    var indexOfObject: Int!
    var dataArray: [Student] = []
    
    var ref = Firebase(url: "https://quest2015.firebaseio.com/students")

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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.dataArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentTableCell", forIndexPath: indexPath) as! StudentTableViewCell
        
        let s = self.dataArray[indexPath.row] as Student
        cell.studentLabel.text = s.name
        // Configure the cell...
        
        
        if s.gender == "M" {
            
            cell.genderImg.image = UIImage(named: "Male")
            
        }
        else if s.gender == "F" {
            
            cell.genderImg.image = UIImage(named: "Female")
            
        }

        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        performSegueWithIdentifier("StudentActivity", sender: indexPath)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
