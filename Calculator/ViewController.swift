//
//  ViewController.swift
//  Calculator
//
//  Created by Amir on 4/19/17.
//  Copyright © 2017 Amir. All rights reserved.
//

import UIKit

enum modes {
    case no_set
    case addition
    case subtraction
    case multi
}
class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var labelString:String = "0"
    var currentMode:modes = .no_set
    var savedNum:Int = 0
    var lastButtonWasMode:Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressPlus(_ sender: Any) {
        changeMode(newMode: .addition)
    }
    @IBAction func didPressSubtract(_ sender: Any) {
        changeMode(newMode: .subtraction)}
    
    @IBAction func didPressMulti(_ sender: Any) {
         changeMode(newMode: .multi)
    }
    
    @IBAction func didPressEquals(_ sender: Any) {
        
        guard let labelInt:Int = Int(labelString) else {
            return }
        
        if(currentMode == .no_set || lastButtonWasMode){
            return
        }
        
        if(currentMode == .addition) {
            savedNum += labelInt
        }
    
        if (currentMode == .subtraction) {
            savedNum -= labelInt
        }
        
        if (currentMode == .multi) {
            savedNum *= labelInt
        }

        
        currentMode = .no_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        
         labelString = "0"
         currentMode = .no_set
         savedNum = 0
         lastButtonWasMode = false
         label.text = "0"

    }
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue:String? = sender.titleLabel?.text
        
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        
        labelString = labelString.appending(stringValue!)
        updateText()
    }

    func updateText() {
        guard let labelInt:Int = Int(labelString) else {
        return }
        
        if (currentMode == .no_set) {
            savedNum = labelInt
        }
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: labelInt)
        
        label.text = formatter.string(from: num)
    }
    
    
    func changeMode (newMode:modes){
        if savedNum == 0 { return
        }
        
        currentMode = newMode
        lastButtonWasMode = true
    }
}

