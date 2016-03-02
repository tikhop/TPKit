//
//  UIGestureRecognizer+TPExtension.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 31/01/16.
//
//

import UIKit


extension UIGestureRecognizer: TPControlActionFunctionProtocol
{
    public func addAction(action: UIGestureRecognizer -> Void)
    {
    }
}

extension TPControlActionFunctionProtocol where Self: UIGestureRecognizer
{
    func addAction(action: Self -> Void)
    {
        let trampoline = TPActionTrampoline(action: action)
        self.addTarget(trampoline, action: "action:")
        objc_setAssociatedObject(self, UIControlActionFunctionProtocolAssociatedObjectKey, trampoline, .OBJC_ASSOCIATION_RETAIN)
    }
}