//
//  NSBundle+TPExtension.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 29/01/16.
//
//

import Foundation

public extension Bundle
{
    public class func appStoreReceiptURL() -> URL?
    {
        return Bundle.main.appStoreReceiptURL
    }
    
    public class func appStoreReceiptData() -> Data?
    {
        if let receiptUrl = appStoreReceiptURL(), let receipt = try? Data(contentsOf: receiptUrl)
        {
            return receipt
        }
        
        return nil
    }
    
    public class func appStoreReceiptBase64() -> String?
    {
        if let receipt = appStoreReceiptData()
        {
            return receipt.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        }
        
        return nil
    }
}
