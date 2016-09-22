//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Rob Sutherland on 2016-09-20.
//  Copyright © 2016 HP Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var recordLabel: UILabel!

    @IBAction func recordAudio(_ sender: AnyObject) {
        print("record button was pressed")
        recordLabel.text = "Record Button was pressed"
        recordButton.isEnabled=false
        stopRecordingButton.isEnabled=true
    }
    @IBAction func stopRecording(_ sender: AnyObject) {
        recordButton.isEnabled=true
        stopRecordingButton.isEnabled=false
        recordLabel.text = "Tap to Record"
    }

    override func viewWillAppear(_ animated: Bool) {
        stopRecordingButton.isEnabled=false
    }
    
}

