//
//  ViewController.swift
//  perfectpetch
//
//  Created by Tawfeeq on 16/10/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit
import AVFoundation

class RecordVC : UIViewController, AVAudioRecorderDelegate{

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    var audioRecorder:AVAudioRecorder!
    var isRecording:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func record(_ sender: Any) {
        
        setButtons(forRecording: isRecording)
        if isRecording {
            isRecording = false
            audioRecorder.stop()
            let session = AVAudioSession.sharedInstance()
            try! session.setActive(false)
        }
        else{
            isRecording = true
            recordAudio()
        }
    }
    
    func setButtons(forRecording recording: Bool) {
        isRecording = recording
        recordButton.setImage(recording ? UIImage(named: "Record") : UIImage(named: "Stop"), for: UIControl.State.normal)
        progressLabel.text = recording ? "Tap to start recording" : "Tap to finish recording"
    }
    
    
    func recordAudio(){
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let file = "record.wav"
        let pathArray = [documentDir,file]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(.playAndRecord, mode: .default)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finish")
        if flag {
            performSegue(withIdentifier: "playSegue", sender: recorder.url)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playSegue"{
            let playVC = segue.destination as! PlayVC
            let recordingFile = sender as! URL
            playVC.recordedAudioURL = recordingFile
        }
    }

}

