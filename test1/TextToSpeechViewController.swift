//
//  TextToSpeechViewController.swift
//  test1
//
//  Created by fypjadmin on 20/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import AVFoundation
import UIKit

class TextToSpeechViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func UIButton(sender: AnyObject?) {
        
        myUtterance = AVSpeechUtterance(string: textView.text)
        myUtterance.rate = 0.0
        synth.speakUtterance(myUtterance)
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
