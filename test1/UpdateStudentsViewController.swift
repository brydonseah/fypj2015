//
//  UpdateStudentsViewController.swift
//  test1
//
//  Created by fypjadmin on 28/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class UpdateStudentsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var studentName: UITextField!
    @IBOutlet var studentClass: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    var student:Student!
    var databasePath = NSString()
    var studentID: Int32!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        studentName.text = student.name
        studentClass.text = student.category
    
        self.imageView.alpha = 0.3 // = UIColor.blackColor().colorWithAlphaComponent(0.3)
    
        self.imageView.image = UIImage(named:"GreenImg")
        //imageView.setbgImageColor(onePixelImageWithColor(bgImageColor))
        
        
        
                

        // Do any additional setup after loading the view.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateStudentDetails() {
        0
        var sStudentID = self.student.studentID
        var sName = studentName.text
        var sClass = studentClass.text
        
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB.open() {
            
            var updateSQL = "UPDATE STUDENT SET NAME = '" + sName + "' , CATEGORY = '" + sClass
            updateSQL += "' WHERE STUDENTID = " + sStudentID.description
            
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
        
        self.performSegueWithIdentifier("UpdateStudentDetail", sender: self)
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpdateStudentDetail" {
            var vc = segue.destinationViewController as! StudentsTableViewController
            vc.studentUpdate = student
            studentName.text = ""
            studentClass.text = ""
        }
    }
    
    func onePixelImageWithColor(color : UIColor) -> UIImage {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(CGImageAlphaInfo.PremultipliedLast.rawValue)
        var context = CGBitmapContextCreate(nil, 1, 1, 8, 0, colorSpace,bitmapInfo)
        CGContextFillRect(context, CGRectMake(0, 0, 1, 1))
        let image = UIImage(CGImage: CGBitmapContextCreateImage(context))
        return image!
        }
    



}