//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Rob Sutherland on 2016-09-20.
//  Copyright © 2016 HP Software. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopRecordingButton: UIButton!
    @IBOutlet var recordLabel: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func recordAudio(_ sender: AnyObject) {
        print("record button was pressed")
        recordLabel.text = "Record Button was pressed"
        recordButton.isEnabled=false
        stopRecordingButton.isEnabled=true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    @IBAction func stopRecording(_ sender: AnyObject) {
        recordButton.isEnabled=true
        stopRecordingButton.isEnabled=false
        recordLabel.text = "Tap to Record"
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    override func viewWillAppear(_ animated: Bool) {
        stopRecordingButton.isEnabled=false
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("audioRecorder did finish recording")
        if(flag){
        self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
            print("Did not record")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

