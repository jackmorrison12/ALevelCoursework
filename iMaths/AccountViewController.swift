//
//  FirstViewController.swift
//  iMaths
//
//  Created by Jack Morrison on 14/09/2016.
//  Copyright © 2016 Jack Morrison. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var noAccountText: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    
    @IBAction func sendDetailsToDatabase(_ sender: UIButton) {
    summary.text = "Not good enough!"
        
        //This is where the username and password which have been entered will be sent to the database for comparison
    }
    
}

