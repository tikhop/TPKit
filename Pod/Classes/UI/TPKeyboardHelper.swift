//
//  TPKeyboardHelper.swift
//  Sugarfish
//
//  Created by Pavel Tikhonenko on 20/02/16.
//  Copyright © 2016 Pavel Tikhonenko. All rights reserved.
//

import UIKit

public typealias TPKeyboardHelperListener = (TPKeyboardInfo) -> ()

public class TPKeyboardHelper
{
    private var listeners = [String: TPKeyboardHelperListener]()
    
    public init()
    {
        subscribeForKeyboardNotifications()
    }
    
    public func addListener<T: Hashable>(listener: T, handler: TPKeyboardHelperListener)
    {
        let key = String(listener.hashValue)
        listeners[key] = handler
    }
    
    public func removeListener<T: Hashable>(listener: T)
    {
        let key = String(listener.hashValue)
        listeners.removeValueForKey(key)
    }
    
    private func subscribeForKeyboardNotifications()
    {
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardDidShowNotification:", name: UIKeyboardDidShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
        center.addObserver(self, selector: "keyboardDidHideNotification:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    private func notifyListeners(info: TPKeyboardInfo)
    {
        listeners.forEach { (listener, block) -> () in
            block(info)
        }
    }
    
    private dynamic func keyboardWillShowNotification(notification: NSNotification)
    {
        handleKeyboardNotification(notification.userInfo, state: .WillShow)
    }
    
    private dynamic func keyboardDidShowNotification(notification: NSNotification)
    {
        handleKeyboardNotification(notification.userInfo, state: .Visible)
    }
    
    private dynamic func keyboardWillHideNotification(notification: NSNotification)
    {
        handleKeyboardNotification(notification.userInfo, state: .WillHide)
    }
    
    private dynamic func keyboardDidHideNotification(notification: NSNotification)
    {
        handleKeyboardNotification(notification.userInfo, state: .Hidden)
    }
    
    private func handleKeyboardNotification(userInfo: [NSObject : AnyObject]?, state: TPKeyboardState)
    {
        notifyListeners(TPKeyboardInfo.fromNotificationUserInfo(userInfo, state: state))
    }
    
    deinit
    {
        listeners.removeAll(keepCapacity: false)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    static let sharedInstance: TPKeyboardHelper = TPKeyboardHelper()
}

public enum TPKeyboardState
{
    case Hidden
    case Visible
    case WillShow
    case WillHide
}

public struct TPKeyboardInfo
{
    public let beginFrame: CGRect
    public let endFrame: CGRect
    
    public let animationCurve: UIViewAnimationCurve
    public let animationDuration: NSTimeInterval
    
    public let state: TPKeyboardState
    
    public static func fromNotificationUserInfo(info: [NSObject : AnyObject]?, state: TPKeyboardState) -> TPKeyboardInfo
    {
        var beginFrame = CGRectZero
        info?[UIKeyboardFrameBeginUserInfoKey]?.getValue(&beginFrame)
        
        var endFrame = CGRectZero
        info?[UIKeyboardFrameEndUserInfoKey]?.getValue(&endFrame)
        
        let curve = UIViewAnimationCurve(rawValue: info?[UIKeyboardAnimationCurveUserInfoKey] as? Int ?? 0) ?? .EaseInOut
        let duration = NSTimeInterval(info?[UIKeyboardAnimationDurationUserInfoKey] as? Double ?? 0.0)
        
        return TPKeyboardInfo(beginFrame: beginFrame, endFrame: endFrame, animationCurve: curve, animationDuration: duration, state: state)
    }
}

public extension TPKeyboardInfo
{
    public var height: CGFloat
        {
            if state == .WillShow || state == .Visible
            {
                return endFrame.size.height
            }
            
            return 0
    }
    
    public var animationOptions: UIViewAnimationOptions
        {
            switch animationCurve
            {
            case .EaseInOut: return UIViewAnimationOptions.CurveEaseInOut
            case .EaseIn: return UIViewAnimationOptions.CurveEaseIn
            case .EaseOut: return UIViewAnimationOptions.CurveEaseOut
            case .Linear: return UIViewAnimationOptions.CurveLinear
            }
    }
}