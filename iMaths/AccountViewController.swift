//
//  AccountViewController.swift
//  iMaths
//
//  Created by Jack Morrison on 14/09/2016.
//  Copyright © 2016 Jack Morrison. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var returnMessage: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var streakText: UILabel!
    @IBOutlet weak var targetText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var tabButton: UITabBarItem!
    @IBOutlet weak var eduLevelText: UILabel!
    
    

    var name = userDefaults.string(forKey: "Name")
    var score = userDefaults.integer(forKey: "Score")
    var streak = userDefaults.integer(forKey: "Streak")
    var target = userDefaults.integer(forKey: "Target")
    var targetProgress = userDefaults.integer(forKey: "TargetProgress")
    var eduLevel = userDefaults.string(forKey: "Education Level")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Launched")
        
        let userDefaults = UserDefaults.standard
        if userDefaults.string(forKey: "isAppAlreadyLaunchedOnce") == nil{
            userDefaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            
            userDefaults.set("Name", forKey: "Name")
            userDefaults.set(0, forKey: "Score")
            userDefaults.set(0, forKey: "Streak")
            userDefaults.set(5, forKey: "Target")
            userDefaults.set(0, forKey: "TargetProgress")
            userDefaults.set("GCSE:", forKey: "Education Level")
            userDefaults.set(NSDate(),forKey:"lastStreakDate")
            userDefaults.synchronize()

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        name = userDefaults.string(forKey: "Name")
        score = userDefaults.integer(forKey: "Score")
        streak = userDefaults.integer(forKey: "Streak")
        target = userDefaults.integer(forKey: "Target")
        targetProgress = userDefaults.integer(forKey: "TargetProgress")
        eduLevel = userDefaults.string(forKey: "Education Level")
        

        var date = NSDate()
        let cal = Calendar(identifier: .gregorian)
        date = (cal.startOfDay(for: date as Date) as NSDate?)!
        var lastStreakDate = userDefaults.lastStreakDate
        lastStreakDate = cal.startOfDay(for: lastStreakDate as! Date) as NSDate?
        let lastStreakDatePlus1 = Calendar.current.date(byAdding: .day, value: 1, to: lastStreakDate as! Date) as NSDate?

        if(lastStreakDate == date){
            print("Same Date")
        }else if(lastStreakDatePlus1 == date){
            if(targetProgress>=target){
                print("Streak Increased")
                streak += 1
                userDefaults.set( streak, forKey: "Streak")
                targetProgress = 0
                userDefaults.set( targetProgress, forKey: "TargetProgress")
                userDefaults.synchronize()
            }else{
                print("Not reached yet today")
            }
        }
        else{
            print("Streak Expired")
            streak = 0
            userDefaults.set( streak, forKey: "Streak")
            targetProgress = 0
            userDefaults.set( targetProgress, forKey: "TargetProgress")
            userDefaults.synchronize()
            lastStreakDate = Calendar.current.date(byAdding: .day, value: -1, to: date as Date) as NSDate?
            userDefaults.set( lastStreakDate, forKey: "lastStreakDate")
            userDefaults.synchronize()
            
            }
        
        super.viewWillAppear(animated)
        returnMessage.text = "Welcome Back \(name!)!"
        questionText.text = "Your score is \(score)"
        streakText.text = "Your current streak is \(streak) days"
        targetText.text = "Today you have answered \(targetProgress)/\(target) of your target"
        eduLevelText.text = "Current education level is set at: \(eduLevel!)"
        progressBar.progress = (Float(targetProgress)/Float(target))
        
    }
    
}

