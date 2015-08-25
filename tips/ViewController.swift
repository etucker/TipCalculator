//
//  ViewController.swift
//  tips
//
//  Created by Eli Tucker on 8/23/15.
//  Copyright © 2015 Eli Tucker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    let tipSettingsKey = "tipControl.selectedSegmentIndex"
    let billFieldSettingsKey = "lastBillField"
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        loadDefaults()
        onEditingChanged(1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.25]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        saveDefaults()
    }

    func loadDefaults() {
        tipControl.selectedSegmentIndex = defaults.integerForKey(tipSettingsKey)
        billField.text = defaults.stringForKey(billFieldSettingsKey)
    }
    
    func saveDefaults() {
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: tipSettingsKey)
        defaults.setObject(billField.text!, forKey: billFieldSettingsKey)
        defaults.synchronize()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

