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
}

public extension TPControlActionFunctionProtocol where Self: UIGestureRecognizer
{
    func addAction(_ action: @escaping (Self) -> Void)
    {
        let trampoline = TPActionTrampoline(action: action)
        self.addTarget(trampoline, action: Selector(("action:")))
        objc_setAssociatedObject(self, UIControlActionFunctionProtocolAssociatedObjectKey, trampoline, .OBJC_ASSOCIATION_RETAIN)
    }
}
