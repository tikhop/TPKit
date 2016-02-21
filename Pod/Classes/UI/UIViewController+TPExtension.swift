//
//  UIViewController+TPExtension.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 20/02/16.
//
//

import UIKit

public extension UIViewController
{
    public func displayChildViewController(vc: UIViewController)
    {
        self.addChildViewController(vc)
        view.addSubview(view)
        vc.didMoveToParentViewController(self)
    }
    
    public func removeViewController(vc: UIViewController)
    {
        vc.willMoveToParentViewController(nil)
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
    }
    
    public func addToViewController(vc: UIViewController)
    {
        vc.addChildViewController(self)
        vc.view.addSubview(view)
        self.didMoveToParentViewController(vc)
    }
    
    public func removeFromViewController()
    {
        willMoveToParentViewController(nil)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
}
