//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Moritz Gort on 25/07/15.
//  Copyright (c) 2015 Gabriele Gort. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var play: AVAudioPlayer! = nil
    var receivedAudio: RecordAudio!
    var audioFile: AVAudioFile!
    
    var engine: AVAudioEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePath, error: nil)
        play = AVAudioPlayer(contentsOfURL: receivedAudio.filePath, fileTypeHint: nil, error: nil)
        play.enableRate = true
        play.volume = 1.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowButtonPressed(sender: UIButton) {
        play.stop()
        play.currentTime = 0.0
        play.rate = 0.5
        play.play()
    }

    @IBAction func fastButtonPressed(sender: UIButton) {
        play.stop()
        play.currentTime = 0.0
        play.rate = 1.5
        play.play()
    }
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playSoundWithVariablePitch(1000)
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        play.stop()
        play.currentTime = 0.0
    }
    
    @IBAction func playDarthVader(sender: UIButton) {
        playSoundWithVariablePitch(-1000)
    }
    
    // MARK: Helper Functions
    
    func playSoundWithVariablePitch(pitch: Int) {
        engine.stop()
        play.stop()
    
        let player: AVAudioPlayerNode = AVAudioPlayerNode()
        let pitchEffect: AVAudioUnitTimePitch = AVAudioUnitTimePitch()
        
        pitchEffect.pitch = Float(pitch)
        
        engine.attachNode(player)
        engine.attachNode(pitchEffect)
        
        engine.connect(player, to: pitchEffect, format: nil)
        engine.connect(pitchEffect, to: engine.outputNode, format: nil)
        
        player.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        engine.startAndReturnError(nil)
        player.play()
    }
}
