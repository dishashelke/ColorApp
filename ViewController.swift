//
//  ViewController.swift
//  ColorApp
//
//  Created by Disha on 9/27/15.
//  Copyright © 2015 Disha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var redValue: UITextField!
    @IBOutlet weak var redScale: UISlider!
    @IBOutlet weak var greenValue: UITextField!
    @IBOutlet weak var greenScale: UISlider!
    @IBOutlet weak var blueValue: UITextField!
    @IBOutlet weak var blueScale: UISlider!
    @IBOutlet weak var colorBox: UIView!
    
    @IBAction func changeRedValue() {
        let red = Int(redScale.value * 100)
        redValue.text = String(red)
    }
    
    @IBAction func changeRedScale() {
        let red = redValue.text
        guard let r = Int(red!) where
            r >= 0 && r <= 100 else {
                handleError(red!,sender:  redValue)
                return
        }
        redScale.value = Float(r)/100
    }
    
    @IBAction func changeGreenValue() {
        let green = Int(greenScale.value * 100)
        greenValue.text = String(green)
    }
    
    @IBAction func changeGreenScale() {
        let green = greenValue.text
        guard let g = Int(green!) where
            g >= 0 && g <= 100 else {
                handleError(green!, sender: greenValue)
                return
        }
        greenScale.value = Float(g)/100
    }
    
    @IBAction func changeBlueValue() {
        let blue = Int(blueScale.value * 100)
        blueValue.text = String(blue)
    }
    
    @IBAction func changeBlueScale() {
        let blue = blueValue.text
        guard let b = Int(blue!) where
            b >= 0 && b <= 100 else {
                handleError(blue!, sender: blueValue)
                return
        }
        blueScale.value = Float(b)/100
    }
    
    @IBAction func showColor() {
        hideKeyboard()
        let red = redValue.text
        let green = greenValue.text
        let blue = blueValue.text
        
        guard let r = Float(red!),
            g = Float(green!),
            b = Float(blue!) else{
                return
        }
        colorBox.backgroundColor = UIColor(red: CGFloat(r/100), green: CGFloat(g/100), blue: CGFloat(b/100), alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restore()
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "applicationDidEnterBackground:",
            name: UIApplicationDidEnterBackgroundNotification,
            object: nil)
    }
    
    func applicationDidEnterBackground(notification: NSNotification) {
        print("in background")
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(Int(redValue.text!)!, forKey: "red")
        userDefaults.setInteger(Int(greenValue.text!)!, forKey: "green")
        userDefaults.setInteger(Int(blueValue.text!)!, forKey: "blue")
    }
    
    func restore() {
        var red = 0, green = 0, blue = 0
        let userDefaults = NSUserDefaults.standardUserDefaults()
        red = userDefaults.integerForKey("red")
        green = userDefaults.integerForKey("green")
        blue = userDefaults.integerForKey("blue")
        redValue.text = "\(red)"
        greenValue.text = "\(green)"
        blueValue.text = "\(blue)"
        updateScales()
        showColor()
    }
    
    func updateScales() {
        changeRedScale()
        changeGreenScale()
        changeBlueScale()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func hideKeyboard() {
        redValue.resignFirstResponder()
        greenValue.resignFirstResponder()
        blueValue.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        hideKeyboard()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Warning", message: "Enter the value in the range of 0 to 100", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func handleError(value: String, sender: UITextField) {
        showError()
        guard let actualValue = Int(value) else{
            sender.text = "0"
            updateScales()
            return
        }
        if actualValue < 0 {
            sender.text = "0"
        }
        else {
            sender.text = "100"
        }
        updateScales()
    }
}

