//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Phai Minh Hoang on 3/12/15.
//  Copyright (c) 2015 Phai. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet var recodingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    var recordAudio: RecordedAudio!
    
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recodingLabel.text = "Tap to Record"
    }
    override func viewWillAppear(animated: Bool) {
        // Hide Stop button and show record button
        stopButton.hidden = true
        recordButton.hidden = false
    }

    @IBAction func recordAudio(sender: UIButton) {
        
        // Hide record button, show stop button and change title of recordingLabel
        recodingLabel.text = "Recording"
        stopButton.hidden = false
        recordButton.hidden = true
        
        // Take director's path
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        // Get current data time
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        
        // Create name of the file by appending current data + wav e.g, 02022015-011234.wav
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            
            // Create PlaySoundVC which is the destination View Controller
            let PlaySoundVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            let data = sender as! RecordedAudio
            
            // Assign Playsound's receiveAudio to data
            PlaySoundVC.receivedAudio = data
        }
        
    }
    
    // After user hits Stop button, if the audio recorded successfully then we performe the segue
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag) {
            recordAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            
            // Perform segue to PlaySoundsViewController
            self.performSegueWithIdentifier("stopRecording", sender: recordAudio)
        } else {
            println("Recording was not succesful")
        }
    }
    
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        recodingLabel.text = "Tap to Record"
        recordButton.hidden = false
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

