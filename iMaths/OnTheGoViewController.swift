//
//  OnTheGoViewController.swift
//  iMaths
//
//  Created by Jack Morrison on 14/09/2016.
//  Copyright © 2016 Jack Morrison. All rights reserved.
//

import UIKit

class OnTheGoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate   {
    
    //MARK:Properties
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var topicSelect: UIPickerView!
    @IBOutlet weak var answerBox: UITextField!
    @IBOutlet weak var answerBox2: UITextField!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    

    var topicData: [String] = [String]() //In Line 5, we’re declaring a new Array instance variable to store the list of data. By declaring it here as an instance variable, we can access this variable from any method in this class and the variable will hold its value for the duration of the objects lifetime.
    var subTopicDataN: [String] = [String]()
    var subTopicDataSt: [String] = [String]()
    var subTopicDataA: [String] = [String]()
    var subTopicDataSh: [String] = [String]()
    var selectedIndex = 0
    var key: [String: [String]] = [:]
    var topic = ""
    var subTopic = ""
    var answer1 = 0
    var answer2 = 0
    var answer1double = 0.0
    var answer2double = 0.0
    var result = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.topicSelect.delegate = self
        self.topicSelect.dataSource = self
        
        answerBox.isHidden = true
        answerBox2.isHidden = true
        submitButton.isHidden = true
        yesButton.isHidden = true
        noButton.isHidden = true
        continueButton.isHidden = true
        
        topicData = ["Number", "Statistics", "Algebra", "Shape"]
        
        subTopicDataN = ["Indicies", "Standard Form", "Decimals", "Percentages", "Fractions"]
        subTopicDataSt = ["Range", "Mode", "Median"]
        subTopicDataA = ["Factorisation", "Linear Equations"]
        subTopicDataSh = ["Circles", "Triangles", "Quadrilaterals", "Transformations"]
        key = ["Number":subTopicDataN,"Statistics":subTopicDataSt,"Algebra":subTopicDataA,"Shape":subTopicDataSh]
        
        self.addDoneButtonOnKeyboard()

    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Close Keyboard", style: UIBarButtonItemStyle.done, target: self, action: #selector(OnTheGoViewController.doneButtonAction))
        let minus: UIBarButtonItem = UIBarButtonItem(title: "-", style: UIBarButtonItemStyle.done, target: self, action: #selector(OnTheGoViewController.printMinus))
        
        var items = [UIBarButtonItem]()
        items.append(minus)
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.answerBox.inputAccessoryView = doneToolbar
        self.answerBox2.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction() {
        self.answerBox.resignFirstResponder()
        self.answerBox2.resignFirstResponder()
    }
    
    func printMinus(){
        if(answerBox.isFirstResponder){
            answerBox.text! += "-"
        } else{
            answerBox2.text! += "-"
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component==0){
            return key.count
        }
        else{
            switch selectedIndex{
            case 0:
                return key["Number"]!.count
            case 1:
                return key["Statistics"]!.count
            case 2:
                return key["Algebra"]!.count
            case 3:
                return key["Shape"]!.count
            default:
                return key["Number"]!.count
            }
            
        }
        
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            return topicData[row]
        }else{
            switch selectedIndex{
            case 0:
                return subTopicDataN[row]
            case 1:
                return subTopicDataSt[row]
            case 2:
                return subTopicDataA[row]
            case 3:
                return subTopicDataSh[row]
            default:
                return subTopicDataN[row]
            }
        }
        
    }
    
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = topicSelect.selectedRow(inComponent:0);
        topicSelect.reloadAllComponents()
        topic = topicData[topicSelect.selectedRow(inComponent:0)]
        switch selectedIndex{
        case 0:
            subTopic = subTopicDataN[topicSelect.selectedRow(inComponent:1)]
        case 1:
            subTopic = subTopicDataSt[topicSelect.selectedRow(inComponent:1)]
            
        case 2:
            subTopic = subTopicDataA[topicSelect.selectedRow(inComponent:1)]
            
        case 3:
            subTopic = subTopicDataSh[topicSelect.selectedRow(inComponent:1)]
            
        default:
            subTopic = subTopicDataN[topicSelect.selectedRow(inComponent:1)]
            
        }
        selectButton.setTitle("Generate \(subTopic) Question", for: .normal)
        
    }
    
    @IBAction func generateQuestion(sender:UIButton) {
        yesButton.isHidden = true
        noButton.isHidden = true
        topicSelect.isHidden = true
        selectButton.isHidden = true
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.frame.size.width = 300
        questionLabel.sizeToFit()
        
        
        switch subTopic{
        case "Mode":
            answerBox.isHidden = false
            submitButton.isHidden = false
            let(question,actualanswer) = mode()
            questionLabel.text = question
            answer1 = actualanswer
        case "Median":
            answerBox.isHidden = false
            submitButton.isHidden = false
            let(question,actualanswer) = median()
            questionLabel.text = question
            answer1double = actualanswer
        case "Mean":
            answerBox.isHidden = false
            submitButton.isHidden = false
            let(question,actualanswer) = mean()
            questionLabel.text = question
            answer1double = actualanswer
        case "Range":
            answerBox.isHidden = false
            submitButton.isHidden = false
            let(question,actualanswer) = range()
            questionLabel.text = question
            answer1 = actualanswer
        case "Quadratic Formula":
            answerBox.isHidden = false
            answerBox2.isHidden = false
            submitButton.isHidden = false
            let(question,actualanswer, actualanswer2) = quadraticFormula()
            questionLabel.text = question
            answer1double = actualanswer
            answer2double = actualanswer2
        case "Factorisation":
            answerBox.isHidden = false
            answerBox2.isHidden = false
            submitButton.isHidden = false
            let(question,actualanswer, actualanswer2) = factorise()
            questionLabel.text = question
            answer1 = actualanswer
            answer2 = actualanswer2
        case "Completing the Square":
            answerBox.isHidden = false
            answerBox2.isHidden = false
            submitButton.isHidden = false
            let(question,actualanswer, actualanswer2) = completeSquare()
            questionLabel.text = question
            answer1 = actualanswer
            answer2 = actualanswer2
        case "Linear Equations":
            answerBox.isHidden = false
            submitButton.isHidden = false
            let(question,actualanswer) = linearEquation()
            questionLabel.text = question
            answer1double = actualanswer
        case "Decimals":
            answerBox.isHidden = false
            submitButton.isHidden = false
            let random = Int(arc4random_uniform(2))+1
            if(random == 1){
                let(question,actualanswer) = f2d()
                questionLabel.text = question
                answer1double = actualanswer
            }else{
                let(question,actualanswer) = p2d()
                questionLabel.text = question
                answer1double = actualanswer
            }
        case "Fractions":
            answerBox.isHidden = false
            answerBox.placeholder = "Numerator"
            answerBox2.isHidden = false
            answerBox2.placeholder = "Denominator"
            submitButton.isHidden = false
            let random = Int(arc4random_uniform(2))+1
            if(random == 1){
                let(question,actualanswer1, actualanswer2) = p2f()
                questionLabel.text = question
                answer1 = actualanswer1
                answer2 = actualanswer2
            }else{
                let(question,actualanswer1, actualanswer2) = d2f()
                questionLabel.text = question
                answer1 = actualanswer1
                answer2 = actualanswer2
            }
        case "Percentages":
            answerBox.isHidden = false
            submitButton.isHidden = false
            let random = Int(arc4random_uniform(2))+1
            if(random == 1){
                let(question,actualanswer) = f2p()
                questionLabel.text = question
                answer1double = actualanswer
            }else{
                let(question,actualanswer) = d2p()
                questionLabel.text = question
                answer1double = Double(actualanswer)
            }
        default:
            questionLabel.text = "This question topic is not ready yet, please click below to continue"
            submitButton.isHidden = false
        }

    }
    @IBAction func getVal () {
        doneButtonAction()
        var ansNoAndType = ""
        switch subTopic{
        case "Mode":
            ansNoAndType = "1i"
        case "Median":
            ansNoAndType = "1d"
        case "Mean":
            ansNoAndType = "1d"
        case "Range":
            ansNoAndType = "1i"
        case "Quadratic Formula":
            ansNoAndType = "2d"
        case "Factorisation":
            ansNoAndType = "2i"
        case "Completing the Square":
            ansNoAndType = "2i"
        case "Linear Equations":
            ansNoAndType = "1d"
        case "Decimals":
            ansNoAndType = "1d"
        case "Fractions":
            ansNoAndType = "2i"
        case "Percentages":
            ansNoAndType = "1d"
        default:
            questionLabel.text = "This question topic is not ready yet, please click below to continue"
        }
        switch ansNoAndType{
        case "1i":
            if(answerBox.text?.isEmpty)! || (checkIfNumber(toCheck: answerBox.text!)) || (checkIfInt(toCheck:answerBox.text!)){
                questionLabel.text = "No valid answer input"
                result = false
            }else{
                var userInput1: Int = Int(answerBox.text!)!
                result = checkOneAnswer(&answer1, &userInput1)
            }
        case "1d":
            if(answerBox.text?.isEmpty)! || (checkIfNumber(toCheck: answerBox.text!)) {
                questionLabel.text = "No valid answer input"
                result = false
            }else{
                var userInput1: Double = Double(answerBox.text!)!
                result = checkOneAnswer(&answer1double, &userInput1)
            }
        case "2i":
            if((answerBox.text?.isEmpty)!||(answerBox2.text?.isEmpty)!)||(checkIfNumber(toCheck: answerBox.text!))||(checkIfNumber(toCheck: answerBox2.text!)) || (checkIfInt(toCheck:answerBox.text!)) || (checkIfInt(toCheck:answerBox2.text!)){
                questionLabel.text = "No valid answer input"
                result = false
            }else{
                var userInput1: Int = Int(answerBox.text!)!
                var userInput2: Int = Int(answerBox2.text!)!
                let(result1,result2) = checkTwoAnswers(&answer1, &answer2, &userInput1, &userInput2)
                if((result1==true)&&(result2==true)){
                    result = true
                }else{
                    result = false
                }
            }
        case"2d":
            if((answerBox.text?.isEmpty)!||(answerBox2.text?.isEmpty)!)||(checkIfNumber(toCheck: answerBox.text!))||(checkIfNumber(toCheck: answerBox2.text!)){
                questionLabel.text = "No valid answer input"
                result = false
            }else{
                var userInput1: Double = Double(answerBox.text!)!
                var userInput2: Double = Double(answerBox2.text!)!
                let(result1,result2) = checkTwoAnswers(&answer1double, &answer2double, &userInput1, &userInput2)
                if((result1==true)&&(result2==true)){
                    result = true
                }else{
                    result = false
                }
            }
        default:
            questionLabel.text = "This question topic is not ready yet, please click below to continue"
            result = false
        }
    
        if(result == true){
            questionLabel.text = "That answer is correct!"
            var score = userDefaults.integer(forKey: "Score")
            score += 1
            userDefaults.set( score, forKey: "Score")
            var targetProgress = userDefaults.integer(forKey: "TargetProgress")
            let target = userDefaults.integer(forKey: "Target")
            print(target, targetProgress)
            if(targetProgress<target){
                targetProgress += 1
                userDefaults.set( targetProgress, forKey: "TargetProgress")
            }
            if(targetProgress == target){
                userDefaults.set(NSDate(),forKey:"lastStreakDate")
            }
            userDefaults.synchronize()
            questionLabel.text = questionLabel.text! + " You have now answered \(score) questions correctly!"
            answerBox.text = nil
            answerBox2.text = nil
            answerBox.isHidden = true
            answerBox2.isHidden = true
            submitButton.isHidden = true
            answerBox.placeholder = "Enter Answer Here"
            answerBox2.placeholder = "Enter Other Answer Here"
            continueButton.isHidden = false
        }else if(questionLabel.text == "No valid answer input"){
            questionLabel.text = "Sorry, that answer is not valid. Would you like to try another question of the same type?"
            yesButton.isHidden = false
            noButton.isHidden = false
            answerBox.isHidden = true
            answerBox2.isHidden = true
            submitButton.isHidden = true
            answerBox.text = nil
            answerBox2.text = nil
            answerBox.placeholder = "Enter Answer Here"
            answerBox2.placeholder = "Enter Other Answer Here"
        }else if(questionLabel.text == "This question topic is not ready yet, please click below to continue"){
            questionLabel.text = "Please select a Topic and Sub-Topic:"
            answerBox.text = nil
            answerBox2.text = nil
            answerBox.isHidden = true
            answerBox2.isHidden = true
            submitButton.isHidden = true
            answerBox.placeholder = "Enter Answer Here"
            answerBox2.placeholder = "Enter Other Answer Here"
            topicSelect.isHidden = false
            selectButton.isHidden = false
        }else{
            questionLabel.text = "Sorry, that answer is incorrect. Would you like to try another question of the same type?"
            yesButton.isHidden = false
            noButton.isHidden = false
            answerBox.isHidden = true
            answerBox2.isHidden = true
            submitButton.isHidden = true
            answerBox.text = nil
            answerBox2.text = nil
            answerBox.placeholder = "Enter Answer Here"
            answerBox2.placeholder = "Enter Other Answer Here"
        }
        
        
        
    }
    @IBAction func noRetry (sender: UIButton) {
        yesButton.isHidden = true
        noButton.isHidden = true
        answerBox.text = nil
        answerBox2.text = nil
        answerBox.placeholder = "Enter Answer Here"
        answerBox2.placeholder = "Enter Other Answer Here"
        self.topicSelect.isHidden = false
        self.selectButton.isHidden = false
        questionLabel.text = "Please select a Topic and Sub-Topic:"
    }
    @IBAction func doneCheckingScore (sender: UIButton) {
        continueButton.isHidden = true
        topicSelect.isHidden = false
        selectButton.isHidden = false
        questionLabel.text = "Please select a Topic and Sub-Topic:"
    }

    
    
}

