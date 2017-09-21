//
//  TextFieldMaxLengths.swift
//  Payculator
//
//  Created by Kel Reid on 1/6/17.
//

import Foundation
import UIKit

// View technical doc for explanation
// 1
private var maxLengths = [UITextField: Int]()

// 2
extension UITextField {
    
// 3
    @IBInspectable var maxLength: Int {
        get {
// 4
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
// 5
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControlEvents.editingChanged)
        }
    }
    
    @objc func limitLength(textField: UITextField) {
// 6
        guard let prospectiveText = textField.text, prospectiveText.characters.count > maxLength
        else {
            return
        }
        
        let selection = selectedTextRange
// 7
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = prospectiveText.substring(to: maxCharIndex)
        selectedTextRange = selection
    }
}
