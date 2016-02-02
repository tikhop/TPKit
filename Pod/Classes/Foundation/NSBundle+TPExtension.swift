//
//  NSBundle+TPExtension.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 29/01/16.
//
//

import Foundation

public extension NSBundle
{
    public class func appStoreReceiptURL() -> NSURL?
    {
        return NSBundle.mainBundle().appStoreReceiptURL
    }
    
    public class func appStoreReceiptData() -> NSData?
    {
        if let receiptUrl = appStoreReceiptURL(), let receipt = NSData(contentsOfURL: receiptUrl)
        {
            return receipt
        }
        
        return nil
    }
    
    public class func appStoreReceiptBase64() -> String?
    {
        if let receipt = appStoreReceiptData()
        {
            return receipt.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        }
        
        return nil
    }
}