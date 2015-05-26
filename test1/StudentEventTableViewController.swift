//
//  StudentEventTableViewController.swift
//  test1
//
//  Created by Eugene Tan on 26/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentEventTableViewController: UITableViewController {

    var dataArray: [Event] = []
    var ref = Firebase(url: "https://quest2015.firebaseio.com/activities")
    
    var stud: Student!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
        })
        
//        ref.queryOrderedByKey().observeEventType(.ChildChanged, withBlock: { snapshot in
//            let name = snapshot.value["name"] as! String
//            let datetime = snapshot.value["datetime"] as! String
//            var e = self.dataArray[self.indexOfObject]
//            e.title = name //self.updatedName
//            e.date =  datetime //self.updatedDate
//            println("The updated name is \(name),\(datetime)")
//            self.tableView.reloadData()
//        })
        
        
        ref.queryOrderedByKey().observeEventType(.ChildRemoved, withBlock: { snapshot in
            let name = snapshot.value["name"] as! String
            let datetime = snapshot.value["datetime"] as! String
            println("The removed object name is \(name),\(datetime)")
            self.tableView.reloadData()
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.rowHeight = 121
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
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentEventCell", forIndexPath: indexPath) as! StudentEventTableViewCell
        
         let e = self.dataArray[indexPath.row] as Event
        
        cell.titleLabel.text = e.title
        cell.dateLabel.text = e.date
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        //self.performSegueWithIdentifier("EventDetails", sender: indexPath)
        performSegueWithIdentifier("StudentEvent", sender: indexPath)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if(segue.identifier == "StudentEvent") {
            
             var iPath: NSIndexPath = sender as! NSIndexPath
            var e = self.dataArray[iPath.row]
            let sec = segue.destinationViewController as! StudentEventCheckInViewController
            sec.e = e
            sec.stud = self.stud
        }
    }
    

}
