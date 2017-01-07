//
//  ViewController.swift
//  Payculator
//
// Created by K. Reid on 11/29/16.
//  Copyright © 2016 K. Reid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var payRateTextField: UITextField!
    @IBOutlet var hoursWorkedTextField: UITextField!
    @IBOutlet var percentWithheldTextField: UITextField!
    
    @IBOutlet var weekPayLabel: UILabel!
    @IBOutlet var biweekPayLabel: UILabel!
    @IBOutlet var monthPayLabel: UILabel!
    @IBOutlet var yearPayLabel: UILabel!
    
    // calculate salary function
    @IBAction func calculateSalary(_ sender: Any)
    {
        
        var numberFormatter = NumberFormatter()
        
        func formatPay(_ number:Double) -> String
        {
            numberFormatter.numberStyle = .currencyAccounting
            numberFormatter.maximumIntegerDigits = 9
            numberFormatter.maximumFractionDigits = 2
            return numberFormatter.string(from: NSNumber(value: number))!
        }
        
        var payRate = Double(payRateTextField.text!)
        var hoursWorked = Double(hoursWorkedTextField.text!)
        var percentWithheld = Double(percentWithheldTextField.text!)
        
        if(payRate == nil)
        {
            payRate = 0
        }

        if(hoursWorked == nil)
        {
            hoursWorked = 0
        }
        
        if(percentWithheld == nil)
        {
            percentWithheld = 0
        }
        
        var weekPay = payRate! * hoursWorked!
        
        if(hoursWorked! > 40)
        {
            // overtime algorithm
            weekPay = 40.0 * payRate! + (hoursWorked! - 40.0) * payRate! * 1.5
            weekPay = weekPay * (1 - (percentWithheld! / 100))
        }
        
        else
        {
            weekPay = (payRate! * hoursWorked!) * (1 - (percentWithheld! / 100))
        }
        
        // output week pay
        let weekPayString = formatPay(weekPay)
        weekPayLabel.text = weekPayString 
        
        // output biweek pay
        let biweekPayString = formatPay(weekPay * 2)
        biweekPayLabel.text = biweekPayString 
        
        // output month pay
        let monthPayString = formatPay(weekPay * 52 / 12)
        monthPayLabel.text = monthPayString
        
        // output yearly pay
        let yearPayString = formatPay(weekPay * 52)
        yearPayLabel.text = yearPayString
        
        if(payRate! <= 0)
        {
            let alert = UIAlertController(title: "Alert!", message: "Pay Rate can't be zero or empty", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        
        
        if(hoursWorked! <= 0)
        {
            let alert = UIAlertController(title: "Alert!", message: "Hours Worked can't be zero or empty", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction( UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }

    }

}
