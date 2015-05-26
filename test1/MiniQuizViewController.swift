//
//  MiniQuizViewController.swift
//  test1
//
//  Created by Eugene Tan on 26/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class MiniQuizViewController: UIViewController {
    
    @IBOutlet var bonusTextField: UITextField!
    @IBOutlet var totalAmtTextField: UITextField!
    @IBOutlet var budgetAmtTextField: UITextField!
    @IBOutlet var spentAmtTextField: UITextField!
    
    var studentTotalAmt: String!
    var studentBudget: String!
    var b64string: NSString!
    var stud: Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalAmtTextField.text = studentTotalAmt
        budgetAmtTextField.text = studentBudget
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveShoppingAnswers(sender: UIButton){
        //Firebase - Create
        var ref = Firebase(url: "https://quest2015.firebaseio.com/")
        let postRef = ref.childByAppendingPath("miniQuizShopping")
        let post1 = ["name": "\(stud.name)", "totalAmt": "\(studentTotalAmt)", "budgetAmt": "\(studentBudget)", "amtSpent": "\(spentAmtTextField.text)", "receiptImg": "\(self.b64string)", "bonusQn": "\(bonusTextField.text)"]
        let post1Ref = postRef.childByAutoId()
              //  println(post1Ref)
        post1Ref.setValue(post1)
        
        
        var submitAlert = UIAlertController(title: "Successfully submitted!", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        submitAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.performSegueWithIdentifier("unwindStudentActivityFromQuiz", sender: self)
        }))
        self.presentViewController(submitAlert, animated: true, completion: nil)
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
