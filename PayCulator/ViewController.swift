//
//  ViewController.swift
//  Payculator
//
//  Created by K. Reid on 5/1/16.
//  Copyright © 2016 K. Reid. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Looks for single or multiple taps
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
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
        var payRate = Float(payRateTextField.text!)
        var hoursWorked = Float(hoursWorkedTextField.text!)
        var percentWithheld = Float(percentWithheldTextField.text!)
        
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
            weekPay = 40 * payRate! + (hoursWorked! - 40) * payRate! * 1.5
            weekPay = weekPay * (1 - (percentWithheld! / 100))
        }
        else
        {
            weekPay = (payRate! * hoursWorked!) * (1 - (percentWithheld! / 100))
        }
        
        // format week pay
        let weekPayFormatter = NumberFormatter()
        weekPayFormatter.numberStyle = .currencyAccounting
        
        // format biweek pay
        let biweekPayFormatter = NumberFormatter()
        biweekPayFormatter.numberStyle = .currencyAccounting
        
        // format month pay
        let monthPayFormatter = NumberFormatter()
        monthPayFormatter.numberStyle = .currencyAccounting
        
        // format year pay
        let yearPayFormatter = NumberFormatter()
        yearPayFormatter.numberStyle = .currencyAccounting
        
        // output week pay
        let weekPayString = weekPayFormatter.string(from: NSNumber(value: weekPay))
        weekPayLabel.text = weekPayString ?? "0"
        
        // output biweek pay
        let biweekPayString = biweekPayFormatter.string(from: NSNumber(value: weekPay * 2))
        biweekPayLabel.text = biweekPayString ?? "0"
        
        // output month pay
        let monthPayString = monthPayFormatter.string(from: NSNumber(value: weekPay * 52 / 12))
        monthPayLabel.text = monthPayString ?? "0"
        
        // output yearly pay
        let yearPayString = yearPayFormatter.string(from: NSNumber(value: weekPay * 52))
        yearPayLabel.text = yearPayString ?? "0"
        
        if(payRate!  <= 0)
        {
            let alert = UIAlertController(title: "Alert!", message: "Pay Rate cannot be zero or blank", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if(hoursWorked!  <= 0)
        {
            let alert = UIAlertController(title: "Alert!", message: "Hours Worked cannot be zero or blank", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction( UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        // Data Sources
        
        // Delegates

    }

}
