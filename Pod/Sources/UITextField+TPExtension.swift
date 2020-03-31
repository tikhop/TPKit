//
//  UITextField+TPExtension.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 10/09/16.
//
//

import UIKit

extension UITextField
{
    func finalString(range: NSRange, replacementString string: String) -> String
    {
        let addingCharacter = range.length == 0
        var currentText = text != nil ? text! : ""
        
        if addingCharacter
        {
            return currentText + string
        }else{
            let start = currentText.index(currentText.startIndex, offsetBy: range.location)
            currentText.replaceSubrange(start...currentText.index(after: start), with: "")
            return currentText
        }
    }
}
