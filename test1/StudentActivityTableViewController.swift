//
//  StudentActivityTableViewController.swift
//  test1
//
//  Created by fypjadmin on 25/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentActivityTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        //self.performSegueWithIdentifier("EventDetails", sender: indexPath)
        if (indexPath.row == 0) {
            self.performSegueWithIdentifier("Preparation", sender: self)
        } else if (indexPath.row == 1){
            self.performSegueWithIdentifier("Shopping", sender: self)
        } else if (indexPath.row == 2) {
            self.performSegueWithIdentifier("Feedback", sender: self)
        }
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
