//
//  ViewController.swift
//  screenie
//
//  Created by Ricardo Herrera Petit on 3/31/19.
//  Copyright © 2019 Ricardo Herrera Petit. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var imagePicker: UISegmentedControl!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var micToggle: UISwitch!
 
    var recorder = RPScreenRecorder.shared()
    private var isRecording = false
    
    @IBAction func ImagePicked(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedImageView.image = UIImage(named: "skate")!
        case 1:
            selectedImageView.image = UIImage(named: "food")!
        case 2:
            selectedImageView.image = UIImage(named: "cat")!
        case 3:
            selectedImageView.image = UIImage(named: "nature")!
        default:
            selectedImageView.image = UIImage(named: "skate")!
        }
        
    }
    
    @IBAction func recordBtnWasPressed(_ sender: Any) {
        if !isRecording {
            startRecording()
        } else {
            //stopRecording()
        }
    }
    
    func startRecording() {
        guard recorder.isAvailable else {
            debugPrint("recording is not available at this time")
            return
        }
        
        if micToggle.isOn {
            recorder.isMicrophoneEnabled = true
        } else {
            recorder.isMicrophoneEnabled = false
        }
        
        recorder.startRecording { (error) in
            guard error == nil else  {
                debugPrint("There was an error starting the recording")
                return
            }
            
            debugPrint("Started recording successfully!!!")
            DispatchQueue.main.async {
                self.micToggle.isEnabled = false
                self.recordBtn.setTitleColor(#colorLiteral(red: 0.8957869411, green: 0.2001414299, blue: 0.1402733624, alpha: 1), for: .normal)
                self.recordBtn.setTitle("Stop", for: .normal)
                self.statusLbl.text = "Recording..."
                self.statusLbl.textColor = #colorLiteral(red: 0.8957869411, green: 0.2001414299, blue: 0.1402733624, alpha: 1)
                self.isRecording = true
            }
        
            
        }
    }
    
}

