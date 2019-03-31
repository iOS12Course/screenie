//
//  ViewController.swift
//  screenie
//
//  Created by Ricardo Herrera Petit on 3/31/19.
//  Copyright © 2019 Ricardo Herrera Petit. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController, RPPreviewViewControllerDelegate {

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
            stopRecording()
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
    
    func stopRecording() {
        recorder.stopRecording { (preview, error) in
            guard preview != nil else {
                debugPrint("Preview Controller is not available.")
                return
            }
            
            let alert = UIAlertController(title: "Recording Finished", message: "Would you like to edit or delete your recording?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                self.recorder.discardRecording {
                    debugPrint("Recording successfully deleted!!!")
                }
            })
            let editAction = UIAlertAction(title: "Edit", style: .default, handler: { (action) in
                preview?.previewControllerDelegate = self
                self.present(preview!, animated: true, completion: nil)
            })
            alert.addAction(deleteAction)
            alert.addAction(editAction)
            self.present(alert, animated: true, completion: nil)
            
            self.isRecording = false
            self.viewReset()
           
        }
    }
    
    func viewReset() {
        micToggle.isEnabled = true
        statusLbl.text = "Ready to Record"
        statusLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        recordBtn.setTitle("Record", for: .normal)
        recordBtn.setTitleColor(#colorLiteral(red: 0.08131739954, green: 0.8980392157, blue: 0.1276937282, alpha: 0.8470588235), for: .normal)
    }
    
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true, completion: nil)
    }
}

