//
//  SecondViewController.swift
//  iMaths
//
//  Created by Jack Morrison on 14/09/2016.
//  Copyright © 2016 Jack Morrison. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {



    //MARK:Properties
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var topicSelect: UIPickerView!
    
    var topicData: [String] = [String]() //In Line 5, we’re declaring a new Array instance variable to store the list of data. By declaring it here as an instance variable, we can access this variable from any method in this class and the variable will hold its value for the duration of the objects lifetime.
    var subTopicDataN: [String] = [String]()
    var subTopicDataSt: [String] = [String]()
    var subTopicDataA: [String] = [String]()
    var subTopicDataSh: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.topicSelect.delegate = self
        self.topicSelect.dataSource = self
        
        topicData = ["Number", "Statistics", "Algebra", "Shape"]
        
        subTopicDataN = ["Indicies", "Standard Form", "Decimals", "Percentages", "Fractions"]
        subTopicDataSt = ["Range", "Mode", "Median", "Mean"]
        subTopicDataA = ["Quadratic Formula", "Factorisation", "Completing the Square", "Linear Equations"]
        subTopicDataSh = ["Cricles", "Triangles", "Quadrilaterals", "Transformations"]
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topicData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return topicData[row]
    }

}
