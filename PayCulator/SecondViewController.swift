//
//  Results.swift
//  PayCulator
//
//  Created by K. Reid on 1/16/17.
//  Copyright © 2017 K. Reid. All rights reserved.
//

import UIKit

class Results: UIViewController
{

    var ViewController: ViewController?
    
    Results.ViewController = ViewController
   
    func calculations()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


