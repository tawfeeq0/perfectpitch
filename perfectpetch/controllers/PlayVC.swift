//
//  PlayVC.swift
//  perfectpetch
//
//  Created by Tawfeeq on 16/10/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit
import AVFoundation

class PlayVC: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordingFile:URL!
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupAudio()
    }
    
    @IBAction func play(_ sender: AnyObject){
        guard let button = sender as? UIButton else {
            return
        }
        switch button.tag {
        case ButtonType.slow.rawValue:
            playSound(rate: 0.5)
        case ButtonType.fast.rawValue:
            playSound(rate: 1.5)
        case ButtonType.chipmunk.rawValue:
            playSound(pitch: 1000)
        case ButtonType.vader.rawValue:
            playSound(pitch: -1000)
        case ButtonType.echo.rawValue:
            playSound(echo: true)
        case ButtonType.reverb.rawValue:
            playSound(reverb: true)
        default:
            return
        }
        configureUI(.playing)
    }
    
    @IBAction func stopPlaying(_ sender:Any){
        stopAudio()
    }

    @IBAction func newRecording(_ sender: Any) {
        stopAudio()
        self.navigationController?.popViewController(animated: true)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
}
