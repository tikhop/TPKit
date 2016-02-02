//
//  UIControl+TPExtension.swift
//
//  Created by Pavel Tikhonenko on 18/01/16.
//  Copyright © 2016 Pavel Tikhonenko. All rights reserved.
//
//  Thanks Mike Ash
//  https://www.mikeash.com/pyblog/friday-qa-2015-12-25-swifty-targetaction.html

import UIKit

extension UIControl: TPControlActionFunctionProtocol {}

extension TPControlActionFunctionProtocol where Self: UIControl
{
    func addAction(events: UIControlEvents, _ action: Self -> Void)
    {
        let trampoline = TPActionTrampoline(action: action)
        self.addTarget(trampoline, action: "action:", forControlEvents: events)
        objc_setAssociatedObject(self, UIControlActionFunctionProtocolAssociatedObjectKey, trampoline, .OBJC_ASSOCIATION_RETAIN)
    }
}


