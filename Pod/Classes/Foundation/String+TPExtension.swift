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
    public var first: String
    {
        return String(characters.prefix(1))
    }
    
    public var last: String
    {
        return String(characters.suffix(1))
    }
    
    public var lenght: Int
    {
        return characters.count
    }
    
    public var URLEscapedString: String
    {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    
    public func count() -> Int
    {
        return lenght
    }
    
    public subscript (i:Int) -> Character
    {
        if self.characters.count == 0 { return Character("") }
        
        return self[characters.index(startIndex, offsetBy: i)]
    }
    
    public subscript (i: Int) -> String
    {
        return String(self[i] as Character)
    }
    
    public subscript (r: Range<Int>) -> String
    {
        return substring(with: (characters.index(startIndex, offsetBy: r.lowerBound) ..< characters.index(startIndex, offsetBy: r.upperBound)))
    }
    
    public func replaceMatches(_ pattern: String, withString replacementString: String, ignoreCase: Bool = false) -> String?
    {
        if let regex = TPFoundation.regex(pattern, ignoreCase: ignoreCase)
        {
            let range = NSMakeRange(0, lenght)
            return regex.stringByReplacingMatches(in: self, options: [.anchored], range: range, withTemplate: replacementString)
        }
        
        return nil
    }
    
    public func validAsEmail() -> Bool
    {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
    
    public func rangeFromNSRange(_ nsRange : NSRange) -> Range<String.Index>?
    {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex), let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex), let from = String.Index(from16, within: self), let to = String.Index(to16, within: self) else
        {
            return nil
        }
        
        return from ..< to
    }
        
    public var uppercaseFirstLetter: String
    {
        return first.uppercased() + String(characters.dropFirst())
    }
}

