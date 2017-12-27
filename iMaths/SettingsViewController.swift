//
//  SettingsViewController.swift
//  iMaths
//
//  Created by Jack Morrison on 14/09/2016.
//  Copyright © 2016 Jack Morrison. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UITextFieldDelegate {
    
    //MARK: Properties

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var DQTLabel: UILabel!
    @IBOutlet weak var targetSlider: UISlider!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var eduLevelLabel: UILabel!
    @IBOutlet weak var eduLevelPicker: UISegmentedControl!
    
    var target = userDefaults.integer(forKey: "Target")
    var name = userDefaults.string(forKey: "Name")
    var eduLevel = userDefaults.string(forKey: "Education Level")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        targetSlider.value = Float(target)
        DQTLabel.text = "Daily Question Target (\(target)):"
        let eduLevel = userDefaults.string(forKey: "Education Level")
        for i in 0...3{
            if(eduLevelPicker.titleForSegment(at: i)==eduLevel!){
                eduLevelPicker.selectedSegmentIndex = i
            }
        }
        nameTextField.text = String(name!)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getDQT (sender:UISlider) {
        target = Int(targetSlider.value)
        userDefaults.set( target, forKey: "Target")
        userDefaults.synchronize()
        DQTLabel.text = "Daily Question Target (\(target)):"
        
    }
    
    @IBAction func finishedEnteringName(_ sender: UITextField) {
        self.nameTextField.resignFirstResponder()
        name = nameTextField.text
        userDefaults.set( name, forKey: "Name")
        userDefaults.synchronize()
    }

    @IBAction func eduLevelChanged(_ sender: UISegmentedControl) {
        let selectedSegment = eduLevelPicker.selectedSegmentIndex
        eduLevel = eduLevelPicker.titleForSegment(at: selectedSegment)
        userDefaults.set( eduLevel, forKey: "Education Level")
        userDefaults.synchronize()
    }
    

}

