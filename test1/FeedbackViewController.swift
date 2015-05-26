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
    
    @IBOutlet var yesButton2: UIButton!
    @IBOutlet var noButton2: UIButton!
    
    @IBOutlet var refTextField: UITextField!
    @IBOutlet var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var audioPlayer: AVAudioPlayer!
    
    var filePath: NSURL!
    
    var currentDateTime: NSDate!
    
    var isChecked: Bool = false
    
    var stud: Student!
    
    var checkImgYes = UIImage(named: "yes_selected")
    var uncheckImgYes = UIImage(named: "yes_not_selected")
    
    var checkImgNo = UIImage(named: "no_selected")
    var uncheckImgNo = UIImage(named: "no_not_selected")
    
    
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
    }
    
    @IBAction func noCheckbox(sender: UIButton) {

        self.yesButton.selected = false
        self.yesButton.setImage(uncheckImgYes, forState: UIControlState.Normal)
        self.noButton.selected = true
        self.noButton.setImage(checkImgNo, forState:UIControlState.Normal)
    }
    
    @IBAction func yesCheckbox2(sender: UIButton) {
        self.yesButton2.selected = true
        self.yesButton2.setImage(checkImgYes, forState: UIControlState.Normal)
        self.noButton2.selected = false
        self.noButton2.setImage(uncheckImgNo, forState:UIControlState.Normal)
    }
    
    @IBAction func noCheckbox2(sender: UIButton) {
        self.yesButton2.selected = false
        self.yesButton2.setImage(uncheckImgYes, forState: UIControlState.Normal)
        self.noButton2.selected = true
        self.noButton2.setImage(checkImgNo, forState:UIControlState.Normal)
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
