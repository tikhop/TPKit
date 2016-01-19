//
//  UIControl+TPExtension.swift
//
//  Created by Pavel Tikhonenko on 18/01/16.
//  Copyright © 2016 Pavel Tikhonenko. All rights reserved.
//
//  Thanks Mike Ash
//  https://www.mikeash.com/pyblog/friday-qa-2015-12-25-swifty-targetaction.html

import UIKit

private class ActionTrampoline<T>: NSObject
{
    var action: T -> Void
    
    init(action: T -> Void)
    {
        self.action = action
    }
    
    @objc func action(sender: UIControl)
    {
        action(sender as! T)
    }
}

let NSControlActionFunctionProtocolAssociatedObjectKey = UnsafeMutablePointer<Int8>.alloc(1)

protocol TPControlActionFunctionProtocol {}
extension UIControl: TPControlActionFunctionProtocol {}

extension TPControlActionFunctionProtocol where Self: UIControl
{
    func addAction(events: UIControlEvents, _ action: Self -> Void)
    {
        let trampoline = ActionTrampoline(action: action)
        self.addTarget(trampoline, action: "action:", forControlEvents: events)
        objc_setAssociatedObject(self, NSControlActionFunctionProtocolAssociatedObjectKey, trampoline, .OBJC_ASSOCIATION_RETAIN)
    }
}


