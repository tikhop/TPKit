//
//  TPFoundation.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 18/01/16.
//
//

import Foundation

class TPFoundation
{
    internal class func regex(pattern: String, ignoreCase: Bool = false) -> NSRegularExpression?
    {
        var options = NSRegularExpressionOptions.DotMatchesLineSeparators.rawValue
        
        if ignoreCase
        {
            options = NSRegularExpressionOptions.CaseInsensitive.rawValue | options
        }
        
        var regex: NSRegularExpression?
        
        do
        {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions(rawValue: options))
        } catch _ {
            //Error
        }
        
        return regex
    }
}