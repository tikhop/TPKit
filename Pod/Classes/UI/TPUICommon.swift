//
//  TPUICommon.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 31/01/16.
//
//

import UIKit

internal class TPActionTrampoline<T>: NSObject
{
    var action: (T) -> Void
    
    init(action: @escaping (T) -> Void)
    {
        self.action = action
    }
    
    @objc func action(_ sender: NSObject)
    {
        action(sender as! T)
    }
}

let UIControlActionFunctionProtocolAssociatedObjectKey = UnsafeMutablePointer<Int8>.allocate(capacity: 1)

public protocol TPControlActionFunctionProtocol {}
