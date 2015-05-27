//
//  CameraViewController.swift
//  test1
//
//  Created by fypjadmin on 22/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit
import MobileCoreServices

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    @IBOutlet var imagen: UIImageView!
    @IBOutlet var saveButton: UIButton!
    
    var studentTotalAmt: String!
    var studentBudget: String!
    
    var b64string: NSString!
    var stud: Student!
    
    var ref = Firebase(url: "https://quest2015.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagen.layer.cornerRadius = 8.0
        imagen.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func useCamera(sender: UIBarButtonItem){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        
        //para seleccionar solo los controles de camara y no de video
        imagePicker.mediaTypes = [kUTTypeImage]
        imagePicker.showsCameraControls = true
        //imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImagePNGRepresentation(image) as NSData 
        imagen.image = image
        
        //guarda en album de fotos
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
        //guarda en documents
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last as! NSString
        var currentDate = NSDate()
        let filePath = documentsPath.stringByAppendingPathComponent("\(currentDate).png")
        imageData.writeToFile(filePath, atomically: true)
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func savePhoto(sender: UIButton){
    
        var saveImg: UIImage = imagen.image!
        
        let imageData = UIImageJPEGRepresentation(saveImg, 0.0)
        
        b64string = imageData.base64EncodedStringWithOptions(.allZeros)
//
//        var usersRef = ref.childByAppendingPath("images")
//        
//        var post = ["image": self.b64string]
//        
//        let postRef = usersRef.childByAutoId()
//        
//        postRef.setValue(post)
//        
//        
//        var loginSuccess = UIAlertController(title: "Photo is saved.", message: "", preferredStyle: UIAlertControllerStyle.Alert)
//        loginSuccess.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
//        }))
//        
//        self.presentViewController(loginSuccess, animated: true, completion: nil)
        self.performSegueWithIdentifier("miniQuiz", sender: self)

    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>){
        if(error != nil){
            println("ERROR IMAGE \(error.debugDescription)")
        }
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let mq = segue.destinationViewController as! MiniQuizViewController
        mq.studentTotalAmt = self.studentTotalAmt
        mq.studentBudget = self.studentBudget
        mq.b64string = self.b64string
        mq.stud = self.stud
    }
    

}
