//
//  StudentQuizViewController.swift
//  test1
//
//  Created by fypjadmin on 28/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class StudentQuizViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    
    @IBOutlet var correctWrongLabel: UILabel!
    
    var correctAnswer = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RandomQuestions()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func RandomQuestions(){
        var randomNum = arc4random() % 4
        randomNum += 1
        
        switch(randomNum){
        
        case 1:
            
            questionLabel.text = "You have $5.00. After buying sweets, you left $2.00. How much is the sweets?"
            button1.setTitle("$4.00", forState: UIControlState.Normal)
            button2.setTitle("$3.00", forState: UIControlState.Normal)
            button3.setTitle("$2.50", forState: UIControlState.Normal)
            button4.setTitle("$6.00", forState: UIControlState.Normal)
            correctAnswer = "2"
            break
            
        case 2:
            questionLabel.text = "10 + 10 = ?"
            button1.setTitle("20", forState: UIControlState.Normal)
            button2.setTitle("5", forState: UIControlState.Normal)
            button3.setTitle("4", forState: UIControlState.Normal)
            button4.setTitle("15", forState: UIControlState.Normal)
            correctAnswer = "1"
            break
            
        case 3:
            questionLabel.text = "You have 3 sweets. John gives you 4 more. How many sweets do you have now?"
            button1.setTitle("1", forState: UIControlState.Normal)
            button2.setTitle("6", forState: UIControlState.Normal)
            button3.setTitle("7", forState: UIControlState.Normal)
            button4.setTitle("10", forState: UIControlState.Normal)
            correctAnswer = "4"
            break
            
        case 4:
            questionLabel.text = "5 + 3 = ?"
            button1.setTitle("5", forState: UIControlState.Normal)
            button2.setTitle("2", forState: UIControlState.Normal)
            button3.setTitle("13", forState: UIControlState.Normal)
            button4.setTitle("8", forState: UIControlState.Normal)
            var text: String = (button4.titleLabel?.text as String?)!
            correctAnswer = text
            break
            
            
        default:
            break
        }
    }
    
    @IBAction func button1Action(sender: AnyObject) {
        if(correctAnswer == "1"){
            correctWrongLabel.text = "You are correct!"
        } else {
            correctWrongLabel.text = "You are wrong!"
        }
    }
    
    @IBAction func button2Action(sender: AnyObject) {
        if(correctAnswer == "2"){
            correctWrongLabel.text = "You are correct!"
        } else {
            correctWrongLabel.text = "You are wrong!"
        }
    }
    
    @IBAction func button3Action(sender: AnyObject) {
        if(correctAnswer == "4"){
            correctWrongLabel.text = "You are correct!"
        } else {
            correctWrongLabel.text = "You are wrong!"
        }
    }
    
    @IBAction func button4Action(sender: AnyObject) {
        if(correctAnswer == "3"){
            correctWrongLabel.text = "You are correct!"
        } else {
            correctWrongLabel.text = "You are wrong!"
        }
    }
    
    @IBAction func buttonNext(sender: AnyObject) {
        RandomQuestions()
        correctWrongLabel.text = " "
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
