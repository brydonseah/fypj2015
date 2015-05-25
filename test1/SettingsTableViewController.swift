//
//  SettingsTableViewController.swift
//  test1
//
//  Created by Eugene Tan on 25/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var ref = Firebase(url: "https://quest2015.firebaseio.com/activities")
    var userEmail: String!
    var userPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("\(userEmail)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindSettingsPage(segue: UIStoryboardSegue){
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == "Logout") {
            ref.unauth()
        } else if(segue.identifier == "changeEmail"){
           
        } else if (segue.identifier == "changePassword"){
            let nav = segue.destinationViewController as! UINavigationController
            let cp = nav.topViewController as! ChangePasswordTableViewController
            cp.userEmail = self.userEmail
        }
    }
    

}
