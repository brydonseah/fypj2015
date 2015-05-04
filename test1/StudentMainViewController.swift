//
//  StudentMainViewController.swift
//  test1
//
//  Created by fypjadmin on 28/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentMainViewController: UIViewController {

    let tm = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as! StudentResultsViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.tm
    }

    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }

}
