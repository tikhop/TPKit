//
//  String+TPExtension.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 08/02/16.
//
//

import Foundation

public extension String
{
    var lenght: Int
    {
        return characters.count
    }
    
    func count() -> Int
    {
        return lenght
    }
    
    subscript (i:Int) -> Character
    {
        if self.characters.count == 0 { return Character("") }
        
        return self[startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String
    {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String
    {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
    
    public func replaceMatches(pattern: String, withString replacementString: String, ignoreCase: Bool = false) -> String?
    {
        if let regex = TPFoundation.regex(pattern, ignoreCase: ignoreCase)
        {
            let range = NSMakeRange(0, lenght)
            return regex.stringByReplacingMatchesInString(self, options: [.Anchored], range: range, withTemplate: replacementString)
        }
        
        return nil
    }
    
    public func validAsEmail() -> Bool
    {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluateWithObject(self)
    }
    
    public func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>?
    {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)

        if let from = String.Index(from16, within: self), let to = String.Index(to16, within: self)
        {
            return from ..< to
        }
        
        return nil
    }
}

