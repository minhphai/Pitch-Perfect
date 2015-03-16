//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Phai Minh Hoang on 3/13/15.
//  Copyright (c) 2015 Phai. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioEngine = AVAudioEngine()
        
        // Initialize audio file, taking the filePathURl in receivedAudio
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudioWithVariablePitch(pitch:Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        // Create node Player
        var pitchPlayer = AVAudioPlayerNode()
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        
        // Attach pitchPlayer and timePitch to audio engine
        audioEngine.attachNode(pitchPlayer)
        audioEngine.attachNode(timePitch)
        
        // Connect pitchPlayer with timePitch
        audioEngine.connect(pitchPlayer, to: timePitch, format:nil)
        
        // Connect timepitch to engine output
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format:nil)
        
        // Add auio file to the player
        pitchPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        pitchPlayer.play()
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    @IBAction func fastButtonPressed(sender: UIButton) {
        // We need to reset audioEngine and stop the player before playing
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.enableRate = true
        audioPlayer.rate = 1.5
        audioPlayer.play()
    }

    @IBAction func slowButtonPressed(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.enableRate = true
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }


    @IBAction func playChipMunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }

    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
}
