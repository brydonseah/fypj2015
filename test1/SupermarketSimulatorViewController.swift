//
//  SupermarketSimulatorViewController.swift
//  test1
//
//  Created by Eugene Tan on 26/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class SupermarketSimulatorViewController: UIViewController {

    @IBOutlet var nextButton: UIButton!
    
    var studentTotalAmt: String!
    var studentBudget: String!
    var stud: Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
    
    @IBAction func nextButton(sender: UIButton){
        self.performSegueWithIdentifier("receiptPhoto", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "receiptPhoto") {
            let rp = segue.destinationViewController as! CameraViewController
            rp.studentTotalAmt = self.studentTotalAmt
            rp.studentBudget = self.studentBudget
            rp.stud = self.stud
        }
    }
    

}
