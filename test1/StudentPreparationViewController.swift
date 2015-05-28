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
    
    @IBOutlet var imageView: UIImageView!
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
        
        instructionTextView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        self.imageView.alpha = 0.9 // = UIColor.blackColor().colorWithAlphaComponent(0.3)
        self.imageView.image = UIImage(named:"img2")

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
        
        let budget: Int = self.budgetAmtTextField.text.toInt()!
        let totalAmt: Int = self.totalAmtTextField.text.toInt()!
        
        println(budget)
        println(totalAmt)
        
        if (budget > totalAmt) {
            let alert = UIAlertView()
            alert.title = "Budget more than wallet amount!"
            alert.message = "Please check again."
            alert.addButtonWithTitle("Ok")
            alert.show()

        } else {
        
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
            
        }
    }
    

}
