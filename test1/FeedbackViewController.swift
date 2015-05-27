//
//  FeedbackViewController.swift
//  test1
//
//  Created by Eugene Tan on 26/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit
import AVFoundation

class FeedbackViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var yesButton2: UIButton!
    @IBOutlet var noButton2: UIButton!
    
    @IBOutlet var refTextField: UITextField!
    @IBOutlet var recordButton: UIButton!
    
    @IBOutlet var submitButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var audioPlayer: AVAudioPlayer!
    
    var filePath: NSURL!
    
    var currentDateTime: NSDate!
    
    var isChecked: Bool = false
    
    var stud: Student!
    
    var string1: String!
    var string2: String!
    
    var checkImgYes = UIImage(named: "yes_selected")
    var uncheckImgYes = UIImage(named: "yes_not_selected")
    
    var checkImgNo = UIImage(named: "no_selected")
    var uncheckImgNo = UIImage(named: "no_not_selected")
    
    var fileLocation: NSString!
    var base64String: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.noButton.setImage(uncheckImgNo, forState: UIControlState.Normal)
        self.yesButton.selected = false
        self.yesButton.setImage(uncheckImgYes, forState: UIControlState.Normal)
        self.noButton.selected = false
        
        
        self.noButton2.setImage(uncheckImgNo, forState: UIControlState.Normal)
        self.yesButton2.selected = false
        self.yesButton2.setImage(uncheckImgYes, forState: UIControlState.Normal)
        self.noButton2.selected = false
        
        submitButton.addTarget(self, action: "submitFeedback:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.imageView.alpha = 0.9 // = UIColor.blackColor().colorWithAlphaComponent(0.3)
        self.imageView.image = UIImage(named:"img2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveResponse(sender: UIButton){
        
    }
    
    @IBAction func yesCheckbox(sender: UIButton) {
        
        self.yesButton.selected = true
        self.yesButton.setImage(checkImgYes, forState: UIControlState.Normal)
        self.noButton.selected = false
        self.noButton.setImage(uncheckImgNo, forState:UIControlState.Normal)
        string1 = "Yes"
    }
    
    @IBAction func noCheckbox(sender: UIButton) {

        self.yesButton.selected = false
        self.yesButton.setImage(uncheckImgYes, forState: UIControlState.Normal)
        self.noButton.selected = true
        self.noButton.setImage(checkImgNo, forState:UIControlState.Normal)
        string1 = "No"
    }
    
    @IBAction func yesCheckbox2(sender: UIButton) {
        self.yesButton2.selected = true
        self.yesButton2.setImage(checkImgYes, forState: UIControlState.Normal)
        self.noButton2.selected = false
        self.noButton2.setImage(uncheckImgNo, forState:UIControlState.Normal)
        string2 = "Yes"
    }
    
    @IBAction func noCheckbox2(sender: UIButton) {
        self.yesButton2.selected = false
        self.yesButton2.setImage(uncheckImgYes, forState: UIControlState.Normal)
        self.noButton2.selected = true
        self.noButton2.setImage(checkImgNo, forState:UIControlState.Normal)
        string2 = "No"
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        
        //Find Document Directory
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        //Get current time and format it
        currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        
        //Set the recording name to our date string and create a file path
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        //Start an audio session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        //Initialize the audio recorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()

    }
    
    @IBAction func stopRecordingAudio(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        var error: NSError?
        
        var fileLocation = NSString(string:NSBundle.mainBundle().pathForResource("\(currentDateTime)", ofType: "wav")!)
        let fileData = NSData(contentsOfFile: fileLocation as String, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &error)
        base64String = fileData?.base64EncodedStringWithOptions(.allZeros)
        println(base64String)

    }
    
    @IBAction func submitFeedback(sender: UIButton){
        
        if( string1 == "" || string2 == "" || refTextField.text == "") {
            
            let alert = UIAlertView()
            alert.title = "Error submitting!"
            alert.message = "Please check again."
            alert.addButtonWithTitle("Ok")
            alert.show()
        
        } else {
        
        //Firebase - Create
        var ref = Firebase(url: "https://quest2015.firebaseio.com/")
        let postRef = ref.childByAppendingPath("feedbacks")
        let post1 = ["name": "\(stud.name)", "q1": "\(string1)", "q2": "\(string2)", "q3": "\(refTextField.text)", "q3Audio": "\(base64String)"]
        let post1Ref = postRef.childByAutoId()
        //        println(post1Ref)
        post1Ref.setValue(post1)
        
        var submitAlert = UIAlertController(title: "Successfully submitted!", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        submitAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.performSegueWithIdentifier("unwindStudActivity", sender: self)
        }))
        self.presentViewController(submitAlert, animated: true, completion: nil)
        }

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
