//
//  FeedbackViewController.swift
//  test1
//
//  Created by Eugene Tan on 26/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit
import AVFoundation

class FeedbackViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    @IBOutlet var yesButton2: UIButton!
    @IBOutlet var noButton2: UIButton!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var refTextField: UITextField!
    
    
    @IBOutlet var submitButton: UIButton!
    
   
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var recordButton: UIButton!
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
    
    var micImg = UIImage(named: "Micro-50")
    
    var base64String: String!
    var soundFilePath: String!
    
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
        
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = dirPaths[0] as! String
        soundFilePath =
            docsDir.stringByAppendingPathComponent("test.caf")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let recordSettings =
        [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        
        var error: NSError?
        
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord,
            error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        }
        
        audioRecorder = AVAudioRecorder(URL: soundFileURL,
            settings: recordSettings as [NSObject : AnyObject], error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        } else {
            audioRecorder?.prepareToRecord()
        }
        self.imageView.alpha = 0.9
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
        
//        self.recordButton.enabled = false
//        self.recordButton.setTitle("Recording..", forState: UIControlState.Normal)
//        self.stopRecordButton.hidden = false
//        
//        //Find Document Directory
//        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
//        
//        //Get current time and format it
//        currentDateTime = NSDate()
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "ddMMyyyy-HHmmss"
//        
//        //Set the recording name to our date string and create a file path
//        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
//        let pathArray = [dirPath, recordingName]
//        filePath = NSURL.fileURLWithPathComponents(pathArray)
//        println(filePath)
//        
//        //Start an audio session
//        var session = AVAudioSession.sharedInstance()
//        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
//        
//        //Initialize the audio recorder
//        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
//        audioRecorder.meteringEnabled = true
//        audioRecorder.delegate = self
//        audioRecorder.prepareToRecord()
//        audioRecorder.record()
        if audioRecorder?.recording == false {
            playButton.enabled = false
            stopButton.enabled = true
            audioRecorder?.record()
        }

        
    }
    
    @IBAction func stopRecordingAudio(sender: UIButton) {
        
//        stopRecordButton.hidden = true
//        recordButton.enabled = true
//        recordButton!.setTitle("Start Recording", forState: UIControlState.Normal)
//        audioRecorder.stop()
//        var audioSession = AVAudioSession.sharedInstance()
//        audioSession.setActive(false, error: nil)
        
        stopButton.enabled = false
        playButton.enabled = true
        recordButton.enabled = true
        
        if audioRecorder?.recording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }


    }
    
    @IBAction func submitFeedback(sender: UIButton){
        
        if( string1 == "" || string2 == "" ) {
            
            let alert = UIAlertView()
            alert.title = "Error submitting!"
            alert.message = "Please check again."
            alert.addButtonWithTitle("Ok")
            alert.show()
        
        } else {
        
            var error: NSError?
            
            let fileData = NSData(contentsOfFile: soundFilePath, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &error)
            
            base64String = fileData?.base64EncodedStringWithOptions(.allZeros)
            
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
    
    @IBAction func playAudio(sender: AnyObject) {
        if audioRecorder?.recording == false {
            stopButton.enabled = true
            recordButton.enabled = false
            
            var error: NSError?
            
            audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder?.url,
                error: &error)
            
            audioPlayer?.delegate = self
            
            if let err = error {
                println("audioPlayer error: \(err.localizedDescription)")
            } else {
                audioPlayer?.play()
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        recordButton.enabled = true
        stopButton.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        println("Audio Record Encode Error")
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
