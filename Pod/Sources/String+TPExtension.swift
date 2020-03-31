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
    var URLEscapedString: String
    {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
        
    func validAsEmail() -> Bool
    {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
    
    func range(from nsRange : NSRange) -> Range<String.Index>?
    {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex), let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex), let from = String.Index(from16, within: self), let to = String.Index(to16, within: self) else
        {
            return nil
        }
        
        return from ..< to
    }
        
    var uppercaseFirstLetter: String
    {
        return String(prefix(1) + dropFirst())
    }
}

