//
//  StudentPreparationViewController.swift
//  test1
//
//  Created by Eugene Tan on 26/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import AVFoundation
import UIKit

class StudentPreparationViewController: UIViewController {
    
    @IBOutlet var twoDollarStepper: UIStepper!
    @IBOutlet var fiveDollarStepper: UIStepper!
    @IBOutlet var tenDollarStepper: UIStepper!
    
    @IBOutlet var tenDollarLabel: UILabel!
    @IBOutlet var fiveDollarLabel: UILabel!
    @IBOutlet var twoDollarLabel: UILabel!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var instructionTextView: UITextView!
    
    @IBOutlet var totalAmtTextField: UITextField!
    
    @IBOutlet var budgetAmtTextField: UITextField!
    
    @IBOutlet var submitButton: UIButton!
    
    var twoDollarAmt: Int = 0
    var fiveDollarAmt: Int = 0
    var tenDollarAmt: Int = 0
    
    var stud: Student!
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func preparationTextToSpeech(sender: UIButton) {
        
        myUtterance = AVSpeechUtterance(string: instructionTextView.text)
        myUtterance.rate = 0.0
        synth.speakUtterance(myUtterance)
    }
    
    @IBAction func twoDollar(sender: UIStepper) {
        twoDollarAmt = Int(twoDollarStepper.value * 2)
        twoDollarLabel.text = "$\(twoDollarAmt)"
        totalAmtTextField.text = "\(twoDollarAmt + fiveDollarAmt + tenDollarAmt)"
        
    }
    
    @IBAction func fiveDollar(sender: UIStepper) {
        fiveDollarAmt = Int(fiveDollarStepper.value * 5)
        fiveDollarLabel.text = "$\(fiveDollarAmt)"
        totalAmtTextField.text = "\(twoDollarAmt + fiveDollarAmt + tenDollarAmt)"
    }
    
    @IBAction func tenDollar(sender: UIStepper) {
        tenDollarAmt = Int(tenDollarStepper.value * 10)
        tenDollarLabel.text = "$\(tenDollarAmt)"
        totalAmtTextField.text = "\(twoDollarAmt + fiveDollarAmt + tenDollarAmt)"
    }
    
    @IBAction func submit(sender: UIButton){
        //Firebase - Create
        var ref = Firebase(url: "https://quest2015.firebaseio.com/")
        let postRef = ref.childByAppendingPath("StudentPreparations")
        let post1 = ["name": "\(stud.name)", "totalamt": "\(totalAmtTextField.text)", "budget": "\(budgetAmtTextField.text)"]
        let post1Ref = postRef.childByAutoId()
        //        println(post1Ref)
        post1Ref.setValue(post1)
        
        var submitAlert = UIAlertController(title: "Successfully submitted!", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        submitAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.performSegueWithIdentifier("unwindStudentActivity", sender: self)
        }))
        self.presentViewController(submitAlert, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "unwindStudentActivity") {
            let sa = segue.destinationViewController as! StudentActivityTableViewController
            sa.studentTotalAmt = totalAmtTextField.text
            sa.studentBudget = budgetAmtTextField.text
            
            self.totalAmtTextField.text = ""
            self.budgetAmtTextField.text = ""
        }
    }
    

}
