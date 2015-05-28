//
//  UpdateStudentsViewController.swift
//  test1
//
//  Created by fypjadmin on 28/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class UpdateStudentsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var studentName: UITextField!
    @IBOutlet var studentGender: UITextField!
    @IBOutlet var studentClass: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    var cellColor : UIColor = UIColor(red: (238/255.0), green: (232/255.0), blue: (170/255.0), alpha: 0.8)
    var genderArray = ["M","F"]
    var classArray = ["1A","1B","1C"]
    var student:Student!
    var databasePath = NSString()
    var studentID: Int32!
    var genderPickerView: UIPickerView!
    var classPickerView: UIPickerView!
    var index: Int!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
        let contactDB = FMDatabase(path: databasePath as String)
        
        databasePath = docsDir.stringByAppendingPathComponent(
            "fypj_2015.db")
        
        studentName.backgroundColor = cellColor
        studentGender.backgroundColor = cellColor
        studentClass.backgroundColor = cellColor
        
        studentName.text = student.name
        studentGender.text = student.gender
        studentClass.text = student.category
    
        self.imageView.alpha = 0.9 // = UIColor.blackColor().colorWithAlphaComponent(0.3)
    
        self.imageView.image = UIImage(named:"img3")

        genderPickerView = UIPickerView()
        classPickerView = UIPickerView()
        genderPickerView.dataSource = self
        genderPickerView.delegate = self
        classPickerView.dataSource = self
        classPickerView.delegate = self
        // Do any additional setup after loading the view.
        
        
       //pickerView.setBackgroundColor = cellColor
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        
          genderPickerView.alpha = 0.3
        
        return 1;
        
      
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == genderPickerView {
            
            return genderArray.count
        }
        else if pickerView == classPickerView {
            
            return classArray.count
        }
        else {
            
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if pickerView == genderPickerView {
            
            return genderArray[row]
        }
        else if pickerView == classPickerView {
            
            return classArray[row]
        }
        else {
            
            return nil;
        }
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == genderPickerView {
            
            studentGender.text = genderArray[row]
            studentGender.resignFirstResponder()
        }
        else if pickerView == classPickerView {
            
            studentClass.text = classArray[row]
            studentClass.resignFirstResponder()
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField == studentGender {

            studentGender.inputView = genderPickerView
        }
        else if textField == studentClass {
            
            studentClass.inputView = classPickerView
        }
        
        return true
    }
    
    @IBAction func updateStudentDetails() {
        
//        var sStudentID = self.student.studentID
//        var sName = studentName.text
//        var sGender = studentGender.text
//        var sClass = studentClass.text
//        
//        let contactDB = FMDatabase(path: databasePath as String)
//        
//        if contactDB.open() {
//            
//            var updateSQL = "UPDATE STUDENT SET NAME = '" + sName + "' , GENDER = '" + sGender + "', CATEGORY = '" + sClass
//            updateSQL += "' WHERE STUDENTID = " + sStudentID.description
//            
//            //println(eId.description)
//            let result = contactDB.executeUpdate(updateSQL,
//                withArgumentsInArray: nil)
//            
//            if !result {
//                println("failure")
//                println("Error: \(contactDB.lastErrorMessage())")
//            }
//        } else {
//            
//            println("Error: \(contactDB.lastErrorMessage())")
//
//        }
//        
        self.performSegueWithIdentifier("UpdateStudentDetail", sender: self)
    }
    
//    @IBAction func textFieldEditing(sender: UITextField) {
//        
//        inputGenderView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
//        
//        genderPickerView = UIPickerView(frame: CGRectMake(160, 40, 0, 0))
//        inputGenderView.addSubview(genderPickerView) // add date picker to UIView
//        
//        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
//        doneButton.setTitle("Done", forState: UIControlState.Normal)
//        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
//        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
//        
//        inputGenderView.addSubview(doneButton) // add Button to UIView
//        
//        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
//        
//        sender.inputView = inputGenderView
//        
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpdateStudentDetail" {
            var vc = segue.destinationViewController as! StudentsTableViewController
            vc.studentUpdate = student
            vc.indexOfObject = index
            
            var ref = Firebase(url: "https://quest2015.firebaseio.com/students")
            var hopperRef = ref.childByAppendingPath("\(student.studentID)")
            var updateValue = ["name": "\(self.studentName.text)", "gender": "\(self.studentGender.text)", "class": "\(self.studentClass.text)"]
            hopperRef.updateChildValues(updateValue)
            
            studentName.text = ""
            studentGender.text = ""
            studentClass.text = ""
        }
    }
//    
//    func onePixelImageWithColor(color : UIColor) -> UIImage {
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let bitmapInfo = CGBitmapInfo(CGImageAlphaInfo.PremultipliedLast.rawValue)
//        var context = CGBitmapContextCreate(nil, 1, 1, 8, 0, colorSpace,bitmapInfo)
//        CGContextFillRect(context, CGRectMake(0, 0, 1, 1))
//        let image = UIImage(CGImage: CGBitmapContextCreateImage(context))
//        return image!
//        }
//    
    



}