//
//  ViewController.swift
//  screenie
//
//  Created by Ricardo Herrera Petit on 3/31/19.
//  Copyright © 2019 Ricardo Herrera Petit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var imagePicker: UISegmentedControl!
    
    @IBOutlet weak var selectedImageView: UIImageView!
    
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var micToggle: UISwitch!
 
    

    @IBAction func ImagePicked(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func recordBtnWasPressed(_ sender: Any) {
    }
    
}

