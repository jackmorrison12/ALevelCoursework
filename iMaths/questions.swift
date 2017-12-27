//
//  questions.swift
//  iMaths
//
//  Created by Jack Morrison on 28/12/2016.
//  Copyright © 2016 Jack Morrison. All rights reserved.
//
import UIKit
import Foundation


extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

func exponentize(str: String) -> String {
    
    let supers = [
        "1": "\u{00B9}",
        "2": "\u{00B2}",
        "3": "\u{00B3}",
        "4": "\u{2074}",
        "5": "\u{2075}",
        "6": "\u{2076}",
        "7": "\u{2077}",
        "8": "\u{2078}",
        "9": "\u{2079}"]
    
    var newStr = ""
    var isExp = false
    for (_, char) in str.characters.enumerated() {
        if char == "^" {
            isExp = true
        } else {
            if isExp {
                let key = String(char)
                if supers.keys.contains(key) {
                    newStr.append(Character(supers[key]!))
                } else {
                    isExp = false
                    newStr.append(char)
                }
            } else {
                newStr.append(char)
            }
        }
    }
    return newStr
}

func gcd(_ a: Int, _ b: Int) -> Int {
    let r = a % b
    if r != 0 {
        return gcd(b, r)
    } else {
        return b
    }
}

func quadraticFormula() -> (String,Double,Double){
    var discriminant = 0
    var a = 0
    var b = 0
    var c = 0
    var question = ""
    
    repeat{
        a = Int(arc4random_uniform(198))-99
        b = Int(arc4random_uniform(198))-99
        c = Int(arc4random_uniform(198))-99
        discriminant = b*b-4*a*c
    }while discriminant < 0 || a == 0
    
    if b >= 0 && c >= 0{
        question = ("Solve the quadratic equation\n\(a)x^2 + \(b)x + \(c) = 0\nusing the quadratic formula to 2dp.")
    }else if b >= 0 && c < 0{
        question = ("Solve the quadratic equation\n\(a)x^2 + \(b)x \(c) = 0\nusing the quadratic formula to 2dp.")
    }else if b < 0 && c >= 0{
        question = ("Solve the quadratic equation\n\(a)x^2 \(b)x + \(c) = 0\nusing the quadratic formula to 2dp.")
    }else if b < 0 && c < 0{
        question = ("Solve the quadratic equation\n\(a)x^2 \(b)x \(c) = 0\nusing the quadratic formula to 2dp.")
    }
    
    let answer1 = round(((-1*Double(b)+sqrt(Double(discriminant)))/(2*Double(a)))*100)/100
    let answer2 = round(((-1*Double(b)-sqrt(Double(discriminant)))/(2*Double(a)))*100)/100
    
    question = exponentize(str: question)
    
    return (question,answer1,answer2)
}

func factorise() -> (String,Int,Int){
    let p = Int(arc4random_uniform(20))-10
    let q = Int(arc4random_uniform(20))-10
    var question = ""
    
    if p+q >= 0 && p*q >= 0{
        question = ("Solve the quadratic equation\nx^2 + \(p+q)x + \(p*q) = 0\nusing factorisation")
    }else if p+q >= 0 && p*q < 0{
        question = ("Solve the quadratic equation\nx^2 + \(p+q)x \(p*q) = 0\nusing factorisation")
    }else if p+q < 0 && p*q >= 0{
        question = ("Solve the quadratic equation\nx^2 \(p+q)x + \(p*q) = 0\nusing factorisation")
    }else if p+q < 0 && p*q < 0{
        question = ("Solve the quadratic equation\nx^2 \(p+q)x \(p*q) = 0\nusing factorisation")
    }
    
    
    let answer1 = -1*p
    let answer2 = -1*q
    
    question = exponentize(str: question)
    
    return (question,answer1,answer2)
}


func completeSquare() -> (String,Int,Int){
    var p = 0
    var q = 0
    var question = ""
    
    repeat{
        p = Int(arc4random_uniform(20))-10
        q = Int(arc4random_uniform(10))-10
        q=q*q * -1
    } while p == 0 || q == 0
    
    if 2*p > 0 && (p*p)+q >= 0{
        question = ("Solve the equation\nx^2 + \(2*p)x + \((p*p)+q) = 0\nby completing the square")
    }else if 2*p > 0 && (p*p)+q < 0{
        question = ("Solve the equation\nx^2 + \(2*p)x \((p*p)+q) = 0\nby completing the square")
    }else if 2*p < 0 && (p*p)+q >= 0{
        question = ("Solve the equation\nx^2 \(2*p)x + \((p*p)+q) = 0\nby completing the square")
    }else if 2*p < 0 && (p*p)+q < 0{
        question = ("Solve the equation\nx^2 \(2*p)x \((p*p)+q) = 0\nby completing the square")
    }
    
    let answer1 = Int(sqrt(Double(-1*q))-Double(p))
    let answer2 = Int(-1*sqrt(Double(-1*q))-Double(p))
    
    question = exponentize(str: question)
    
    return (question,answer1,answer2)
}



func createDataSet(type:String) -> [Int]{
    var array: [Int] = []
    
    if type == "mean" || type == "median" || type == "range"{
        
        let arrayLength = Int(arc4random_uniform(5))+5
        
        for _ in 1...arrayLength{
            array.append(Int(arc4random_uniform(98))+1)
        }
        
    }else if type == "mode"{
        
        let arrayLength = (Int(arc4random_uniform(4))+4)
        
        for _ in 1...arrayLength{
            array.append(Int(arc4random_uniform(98))+1)
        }
        
        for _ in 1...(Int(arc4random_uniform(3))+1){
            array.append(array[Int(arc4random_uniform(UInt32(arrayLength)))])
        }
        
    }
    array.shuffle()
    return array
}

func mean() -> (String,Double){
    var array: [Int] = createDataSet(type: "mean")
    var total = 0
    
    for i in 0...((array.count)-1){
        total = total + array[i]
    }
    
    let answer = (Double(total)/Double(array.count)).roundTo(places: 2) // use new round?
    let stringArray = array.flatMap { String($0) }
    let string = stringArray.joined(separator: ", ")
    let question = "Find the mean of the following list of numbers to 2dp:\n\(string)."
    
    return (question,answer)
}

func insertionSort(arrayImport: [Int]) -> ([Int]){
    var array: [Int] = arrayImport
    var x = 0
    var j = 0
    
    for i in 0...((array.count)-1){
        x = array[i]
        j=i-1
        while j>=0 && array[j]>x {
            array[j+1] = array[j]
            j=j-1
        }
        array[j+1] = x
    }
    
    return array
}

func median() -> (String,Double){
    let array: [Int] = createDataSet(type: "median")
    var centre = 0
    var median = 0.0
    let stringArray = array.flatMap { String($0) }
    let string = stringArray.joined(separator: ", ")
    let question = "Find the median of the following list of numbers to 2dp: \(string) "
    var sortedArray: [Int] = insertionSort(arrayImport: array)
    if sortedArray.count % 2 == 1{
        centre = ((sortedArray.count-1) / 2)
        median = Double(sortedArray[centre])
    } else{
        centre = ((sortedArray.count-1) / 2)
        median = Double((Double(sortedArray[centre]) + Double(sortedArray[centre+1])) / 2.0)
    }
    
    let answer = median
    return(question,answer)
}

func range() -> (String,Int){
    let array: [Int] = createDataSet(type: "range")
    var range = 0
    
    let stringArray = array.flatMap { String($0) }
    let string = stringArray.joined(separator: ", ")
    
    let question = "Find the range of the following list of numbers to 2dp:\n\(string)."
    
    var sortedArray: [Int] = insertionSort(arrayImport: array)
    range = sortedArray[sortedArray.count-1]-sortedArray[0]
    let answer = range
    
    return(question,answer)
}

func mode() -> (String,Int){
    
    let array: [Int] = createDataSet(type: "mode")
    let stringArray = array.flatMap { String($0) }
    let string = stringArray.joined(separator: ", ")
    let question = "Find the mode of the following list of numbers to 2dp:\n\(string).\nIf there is more than one, please enter the smallest of these. "
    
    var sortedArray: [Int] = insertionSort(arrayImport: array)
    
    var count = 1
    var maxCount = 1
    var mode = sortedArray[0]
    
    for i in 1...((sortedArray.count)-1){
        if sortedArray[i-1]==sortedArray[i]{
            count = count + 1
            if maxCount < count{
                maxCount = count
                mode = sortedArray[i]
            }
        }else{
            count = 1
        }
    }
    
    let answer = mode
    
    return(question,answer)
}

func linearEquation() -> (String, Double){
    
    var gradient = 0
    var yintercept = 0
    var xintercept = 0
    let qtype = Int(arc4random_uniform(3))
    var question = ""
    var answer = 0.0
    
    repeat{
        gradient = Int(arc4random_uniform(20))-10
        yintercept = Int(arc4random_uniform(20))-10
        xintercept = Int(arc4random_uniform(20))-10
    }while gradient == 0 || xintercept == 0 || yintercept == 0
    
    if qtype == 0{
        
        if yintercept >= 0{
            question = "Where does the equation\ny = \(gradient)x + \(yintercept)\nintersect with the x axis to 2dp?"
        }else{
            question = "Where does the equation\ny = \(gradient)x \(yintercept)\nintersect with the x axis to 2dp?"
        }
        let y = 0
        let x = round((Double(y - yintercept)/Double(gradient))*100)/100
        answer = x
    } else if qtype == 1{
        question = "Where does the equation\ny = \(gradient)x + c\nintersect with the y axis to 2dp if it goes through the point (\(xintercept),0)?"
        let y = 0
        let c = round(Double(y - (gradient*xintercept))*100)/100
        answer = c
    } else{
        question = "What is the gradient of a line which goes through the points (0,\(yintercept)) and (\(xintercept),0) to 2dp?"
        let m = round(Double(yintercept)/(0-Double(xintercept))*100)/100
        answer = m
    }
    
    return(question, answer)
}


func f2d() -> (String, Double){
    
    var numerator = 0
    var denominator = 0
    
    repeat{
        numerator = Int(arc4random_uniform(99))+1
        denominator = Int(arc4random_uniform(99))+1
    }while numerator == 0 || denominator == 0
    
    let question = "What is the fraction \(numerator)/\(denominator) as a decimal to 2dp?"
    
    let answer = round((Double(numerator)/Double(denominator))*100)/100
    
    return (question, answer)
}

func f2p() -> (String, Double){
    
    var numerator = 0
    var denominator = 0
    
    repeat{
        numerator = Int(arc4random_uniform(99))+1
        denominator = Int(arc4random_uniform(99))+1
    }while numerator == 0 || denominator == 0 || numerator>=denominator
    
    let question = "What is the fraction \(numerator)/\(denominator) as a percentage to 2sf?"
    
    let answer = round((Double(numerator)/Double(denominator))*100)
    
    return (question, answer)
}

func d2f() -> (String, Int, Int){
    
    var numerator = 0
    var denominator = 0
    var decimal = 0.0
    var rounded = 0.0
    
    repeat{
        numerator = Int(arc4random_uniform(99))+1
        denominator = Int(arc4random_uniform(99))+1
        
        decimal = Double(numerator)/Double(denominator)
        rounded = round((Double(numerator)/Double(denominator))*100)/100
        
    }while numerator == 0 || denominator == 0 || decimal != rounded || denominator == 1 || numerator == denominator
    
    let question = "What is the decimal \(round((Double(numerator)/Double(denominator))*100)/100) as a fraction in its simplest form?"
    
    let divisor = gcd(numerator,denominator)
    
    numerator = numerator / divisor
    denominator = denominator / divisor
    
    return (question, numerator, denominator)
}

func d2p() -> (String, Int){
    
    let decimal = Double(Int(arc4random_uniform(98))+1)/100
    let question = "What is the decimal \(decimal) as a percentage to 2sf?"
    let answer = Int(decimal*100)
    
    return (question, answer)
}

func p2f() -> (String, Int, Int){
    
    var numerator = 0
    var denominator = 0
    var percentage = 0.0
    var rounded = 0.0
    
    repeat{
        numerator = Int(arc4random_uniform(99))+1
        denominator = Int(arc4random_uniform(99))+1
        
        percentage = Double(numerator)/Double(denominator)
        rounded = round((Double(numerator)/Double(denominator))*100)/100
        
    }while numerator == 0 || denominator == 0 || percentage != rounded || numerator >= denominator
    
    let question = "What is the percentage \(Int(round((Double(numerator)/Double(denominator))*100)))% as a fraction in its simplest form?"
    
    let divisor = gcd(numerator,denominator)
    
    numerator = numerator / divisor
    denominator = denominator / divisor
    
    return (question, numerator, denominator)
}

func p2d() -> (String, Double){
    
    let percentage = (Int(arc4random_uniform(98))+1)
    let question = "What is the percentage \(percentage)% as a decimal to 2dp?"
    let answer = Double(percentage)/100
    
    return (question, answer)
}

func checkOneAnswer<T: Equatable>(_ answer: inout T, _ userInput: inout T) -> (Bool){
    if userInput == answer{
        return true
    }else{
        return false
    }
}

func checkTwoAnswers<T: Equatable>(_ answer1: inout T,_ answer2: inout T, _ userInput1: inout T, _ userInput2: inout T) -> (Bool, Bool){
    if ((userInput1 == answer1) && (userInput2 == answer2))||((userInput2 == answer1) && (userInput1 == answer2)){
        return(true, true)
    }else if ((userInput1 == answer1) && (userInput2 != answer2))||((userInput2 == answer1) && (userInput1 != answer2)){
        return(true, false)
    }else if ((userInput1 != answer1) && (userInput2 == answer2))||((userInput2 != answer1) && (userInput1 == answer2)){
        return(false, true)
    }
    else{
        return(false,false)
    }
}

func checkIfNumber(toCheck:String) -> (Bool){
    
    var str = toCheck
    var numberOfDots=0
    var numberOfMinus=0
    var hasLetterOrSymbol=false
    var minusAtStart=false
    
    for characters in str.characters{
        if(characters == "."){
            numberOfDots += 1
        }else if(characters == "-"){
            numberOfMinus += 1
        }
        if((characters > "9") || (characters < "0")) && (characters != ".") && (characters != "-"){
            hasLetterOrSymbol=true
        }
    }
    if(numberOfMinus == 1){
        var cur = 0
        for characters in str.characters{
            if(cur == 0){
                if(characters == "-"){
                    minusAtStart = true
                }
            }
            cur += 1
        }
    } else{
        minusAtStart = true
    }
    
    if(numberOfDots>1) || (hasLetterOrSymbol==true) || (numberOfMinus>1) || (minusAtStart==false){
        return true
    }else{
        return false
    }
}

func checkIfInt(toCheck:String) -> (Bool){
    var str = toCheck
    
    for characters in str.characters{
        if(characters == "."){
            return true
        }
    }
    return false
}
