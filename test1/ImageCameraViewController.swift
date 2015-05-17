//
//  ImageCameraViewController.swift
//  test1
//
//  Created by fypjadmin on 29/4/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class ImageCameraViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var myImageView: UIImageView!
    
    @IBOutlet var takePhoto: UIButton!
    
    @IBOutlet var photoFromLib: UIButton!
     let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.delegate = self
        
    }
    
    //MARK: Delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        myImageView.contentMode = .ScaleAspectFit //3
        myImageView.image = chosenImage //4
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func photoFromLibrary(sender: UIButton) {
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
//        picker.modalPresentationStyle = .Popover
        presentViewController(picker, animated: true, completion: nil)//4
//        picker.popoverPresentationController?.barButtonItem = sender
    }
    
    @IBAction func shootPhoto(sender: UIButton) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            presentViewController(picker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }

    
    }
    
    

