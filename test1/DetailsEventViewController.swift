//
//  DetailsEventViewController.swift
//  test1
//
//  Created by fypjadmin on 10/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class DetailsEventViewController: UIViewController {

    @IBOutlet var eventNameTextField: UITextField!
    @IBOutlet var dateTimeLabel: UILabel!
    
    var event: Event!
    var databasePath = NSString()
    var idNum: Int32!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as String
        let contactDB = FMDatabase(path: databasePath)
        
        databasePath = docsDir.stringByAppendingPathComponent(
            "fypj2015.db")

       eventNameTextField.text = event.title
       dateTimeLabel.text = event.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateEventDetails(){
        
        //println("method called")
        var eTitle = eventNameTextField.text
        var eDate = self.event.date
        var eId = self.event.id
        
        let contactDB = FMDatabase(path: databasePath)
        
        if contactDB.open() {
            
            var updateSQL = "UPDATE EVENTS SET NAME ='" + eTitle + "', DATETIME ='" + eDate
            updateSQL += "' WHERE ID = " + eId.description
            
            //println(eId.description)
            let result = contactDB.executeUpdate(updateSQL,
                withArgumentsInArray: nil)
            
            if !result {
                println("failure")
                println("Error: \(contactDB.lastErrorMessage())")
            }
        } else {
            
            println("Error: \(contactDB.lastErrorMessage())")
        }
        self.performSegueWithIdentifier("UpdateEventDetail", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpdateEventDetail" {
            var vc = segue.destinationViewController as EventsViewController
            vc.eventUpdate = event
            eventNameTextField.text = ""
            dateTimeLabel.text = "" 
        }
        
            
        
    }
    
    
    
    
    
    

}
