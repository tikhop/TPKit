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
    public func display(_ vc: UIViewController)
    {
        self.addChildViewController(vc)
        view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
    public func remove(_ vc: UIViewController)
    {
        vc.willMove(toParentViewController: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
    }
    
    public func addToViewController(_ vc: UIViewController)
    {
        vc.addChildViewController(self)
        vc.view.addSubview(view)
        self.didMove(toParentViewController: vc)
    }
    
    public func removeFromViewController()
    {
        willMove(toParentViewController: nil)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
}
