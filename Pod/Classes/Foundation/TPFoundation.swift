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
    internal class func regex(_ pattern: String, ignoreCase: Bool = false) -> NSRegularExpression?
    {
        var options = NSRegularExpression.Options.dotMatchesLineSeparators.rawValue
        
        if ignoreCase
        {
            options = NSRegularExpression.Options.caseInsensitive.rawValue | options
        }
        
        var regex: NSRegularExpression?
        
        do
        {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: options))
        } catch _ {
            //Error
        }
        
        return regex
    }
}
