
//
//  NSData+Extension.swift
//  Alias
//
//  Created by Pavel Tikhonenko on 14/04/15.
//  Copyright (c) 2015 Pavel Tikhonenko. All rights reserved.
//

import Foundation

public extension NSData
{
    func hexString() -> NSString
    {
        let str = NSMutableString()
        let bytes = UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count:self.length)
        
        for byte in bytes
        {
            str.appendFormat("%02hhx", byte)
        }
        
        return str
    }
}