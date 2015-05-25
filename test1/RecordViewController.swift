//
//  RecordViewController.swift
//  test1
//
//  Created by fypjadmin on 22/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit
import AVFoundation


class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet var startRecordingButton: UIButton!
    @IBOutlet var stopRecordingButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var audioPlayer: AVAudioPlayer!
    
    var filePath: NSURL!
    
    var currentDateTime: NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startRecordingAudio(sender: UIButton){
        
        stopRecordingButton.hidden = false
        startRecordingButton!.setTitle("Recording...", forState: UIControlState.Normal)
        startRecordingButton.enabled = false
        
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
    
    @IBAction func stopRecordingAudio(sender: UIButton){
        
        //Stop the recording and deactivate the session
        stopRecordingButton.hidden = true
        startRecordingButton.enabled = true
        startRecordingButton!.setTitle("Start Recording", forState: UIControlState.Normal)
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    @IBAction func playRecording(sender: UIButton){
        if audioRecorder?.recording == false {
            startRecordingButton.enabled = true
//            var recording = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("\(currentDateTime)", ofType: "wav")!)
            
            AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
            AVAudioSession.sharedInstance().setActive(true, error: nil)
            
            var error:NSError?
            audioPlayer = AVAudioPlayer(contentsOfURL: filePath, error: &error)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag){
            
            //Save the recorded audio
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            println("recorded success")
            
        } else {
            println("Recording was not successful")
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
