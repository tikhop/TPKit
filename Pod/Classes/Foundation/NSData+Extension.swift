//
//  Created by Pavel Tikhonenko on 14/04/15.
//  Copyright (c) 2015 Pavel Tikhonenko. All rights reserved.
//

import Foundation

public extension Data
{
    public func hexString() -> NSString
    {
        let str = NSMutableString()
        let bytes = UnsafeBufferPointer<UInt8>(start: (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count), count:self.count)
        
        for byte in bytes
        {
            str.appendFormat("%02hhx", byte)
        }
        
        return str
    }
}
