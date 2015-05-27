//
//  TestRecordViewController.swift
//  Quest'15
//
//  Created by fypjadmin on 27/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit
import AVFoundation

class TestRecordViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet var saveButton: UIButton!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var playButton: UIButton!
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    var soundFilePath: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.enabled = false
        stopButton.enabled = false
        
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordAudio(sender: AnyObject) {
        if audioRecorder?.recording == false {
            playButton.enabled = false
            stopButton.enabled = true
            audioRecorder?.record()
        }
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        stopButton.enabled = false
        playButton.enabled = true
        recordButton.enabled = true
        
        if audioRecorder?.recording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
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
    
    @IBAction func saveAudio(sender: AnyObject) {
      
        var error: NSError?
        
        let fileData = NSData(contentsOfFile: soundFilePath, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &error)
        
        let base64String = fileData?.base64EncodedStringWithOptions(.allZeros)
        
        
        var ref = Firebase(url: "https://quest2015.firebaseio.com/")
        let postRef = ref.childByAppendingPath("testAudioSaving")
        let post1 = ["audio": "\(base64String)"]
        let post1Ref = postRef.childByAutoId()
        //        println(post1Ref)
        post1Ref.setValue(post1)
        print("success")

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
