//
//  ReceiptPhotoViewController.swift
//  test1
//
//  Created by Eugene Tan on 26/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit
import MobileCoreServices

class ReceiptPhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var cameraBarButton: UIBarButtonItem!
    @IBOutlet var imagen: UIImageView!
   
    @IBOutlet var nextButton: UIButton!
    var studentTotalAmt: String!
    var studentBudget: String!
    var saveImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImagePNGRepresentation(image) as NSData
        imagen.image = image
        image = self.saveImg
        
        //guarda en album de fotos
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
        //guarda en documents
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last as! NSString
        let filePath = documentsPath.stringByAppendingPathComponent("pic.png")
        imageData.writeToFile(filePath, atomically: true)
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>){
        if(error != nil){
            println("ERROR IMAGE \(error.debugDescription)")
        }
    }
    
    @IBAction func nextButton(sender: UIButton) {
        self.performSegueWithIdentifier("miniQuiz", sender: self)
    }



    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "miniQuiz") {
            let mq = segue.destinationViewController as! MiniQuizViewController
            mq.studentTotalAmt = self.studentTotalAmt
            mq.studentBudget = self.studentBudget
            mq.image = self.saveImg
        }
    }
    

}
