//
//  TPKeyboardHelper.swift
//  Sugarfish
//
//  Created by Pavel Tikhonenko on 20/02/16.
//  Copyright © 2016 Pavel Tikhonenko. All rights reserved.
//

import UIKit

public typealias TPKeyboardHelperListener = (TPKeyboardInfo) -> ()

open class TPKeyboardHelper
{
    fileprivate var listeners = [String: TPKeyboardHelperListener]()
    
    public init()
    {
        subscribeForKeyboardNotifications()
    }
    
    open func addListener<T: Hashable>(_ listener: T, handler: @escaping TPKeyboardHelperListener)
    {
        let key = String(listener.hashValue)
        listeners[key] = handler
    }
    
    open func removeListener<T: Hashable>(_ listener: T)
    {
        let key = String(listener.hashValue)
        listeners.removeValue(forKey: key)
    }
    
    fileprivate func subscribeForKeyboardNotifications()
    {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(TPKeyboardHelper.keyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(TPKeyboardHelper.keyboardDidShowNotification(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        center.addObserver(self, selector: #selector(TPKeyboardHelper.keyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        center.addObserver(self, selector: #selector(TPKeyboardHelper.keyboardDidHideNotification(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    fileprivate func notifyListeners(_ info: TPKeyboardInfo)
    {
        listeners.forEach { (listener, block) -> () in
            block(info)
        }
    }
    
    fileprivate dynamic func keyboardWillShowNotification(_ notification: Notification)
    {
        handleKeyboardNotification((notification as NSNotification).userInfo, state: .willShow)
    }
    
    fileprivate dynamic func keyboardDidShowNotification(_ notification: Notification)
    {
        handleKeyboardNotification((notification as NSNotification).userInfo, state: .visible)
    }
    
    fileprivate dynamic func keyboardWillHideNotification(_ notification: Notification)
    {
        handleKeyboardNotification((notification as NSNotification).userInfo, state: .willHide)
    }
    
    fileprivate dynamic func keyboardDidHideNotification(_ notification: Notification)
    {
        handleKeyboardNotification((notification as NSNotification).userInfo, state: .hidden)
    }
    
    fileprivate func handleKeyboardNotification(_ userInfo: [AnyHashable: Any]?, state: TPKeyboardState)
    {
        notifyListeners(TPKeyboardInfo.fromNotificationUserInfo(userInfo, state: state))
    }
    
    deinit
    {
        listeners.removeAll(keepingCapacity: false)
        NotificationCenter.default.removeObserver(self)
    }
    
    static let sharedInstance: TPKeyboardHelper = TPKeyboardHelper()
}

public enum TPKeyboardState
{
    case hidden
    case visible
    case willShow
    case willHide
}

public struct TPKeyboardInfo
{
    public let beginFrame: CGRect
    public let endFrame: CGRect
    
    public let animationCurve: UIViewAnimationCurve
    public let animationDuration: TimeInterval
    
    public let state: TPKeyboardState
    
    public static func fromNotificationUserInfo(_ info: [AnyHashable: Any]?, state: TPKeyboardState) -> TPKeyboardInfo
    {
        var beginFrame = CGRect.zero
        (info?[UIKeyboardFrameBeginUserInfoKey] as AnyObject).getValue(&beginFrame)
        
        var endFrame = CGRect.zero
        (info?[UIKeyboardFrameEndUserInfoKey] as AnyObject).getValue(&endFrame)
        
        let curve = UIViewAnimationCurve(rawValue: info?[UIKeyboardAnimationCurveUserInfoKey] as? Int ?? 0) ?? .easeInOut
        let duration = TimeInterval(info?[UIKeyboardAnimationDurationUserInfoKey] as? Double ?? 0.0)
        
        return TPKeyboardInfo(beginFrame: beginFrame, endFrame: endFrame, animationCurve: curve, animationDuration: duration, state: state)
    }
}

public extension TPKeyboardInfo
{
    public var height: CGFloat
        {
            if state == .willShow || state == .visible
            {
                return endFrame.size.height
            }
            
            return 0
    }
    
    public var animationOptions: UIViewAnimationOptions
        {
            switch animationCurve
            {
            case .easeInOut: return UIViewAnimationOptions()
            case .easeIn: return UIViewAnimationOptions.curveEaseIn
            case .easeOut: return UIViewAnimationOptions.curveEaseOut
            case .linear: return UIViewAnimationOptions.curveLinear
            }
    }
}
