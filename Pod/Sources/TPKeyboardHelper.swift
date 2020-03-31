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
        center.addObserver(self, selector: #selector(TPKeyboardHelper.keyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(TPKeyboardHelper.keyboardDidShowNotification(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        center.addObserver(self, selector: #selector(TPKeyboardHelper.keyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        center.addObserver(self, selector: #selector(TPKeyboardHelper.keyboardDidHideNotification(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    fileprivate func notifyListeners(_ info: TPKeyboardInfo)
    {
        listeners.forEach { (listener, block) -> () in
            block(info)
        }
    }
    
    @objc fileprivate dynamic func keyboardWillShowNotification(_ notification: Notification)
    {
        handleKeyboardNotification((notification as NSNotification).userInfo, state: .willShow)
    }
    
    @objc fileprivate dynamic func keyboardDidShowNotification(_ notification: Notification)
    {
        handleKeyboardNotification((notification as NSNotification).userInfo, state: .visible)
    }
    
    @objc fileprivate dynamic func keyboardWillHideNotification(_ notification: Notification)
    {
        handleKeyboardNotification((notification as NSNotification).userInfo, state: .willHide)
    }
    
    @objc fileprivate dynamic func keyboardDidHideNotification(_ notification: Notification)
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
    
    public let animationCurve: UIView.AnimationCurve
    public let animationDuration: TimeInterval
    
    public let state: TPKeyboardState
    
    public static func fromNotificationUserInfo(_ info: [AnyHashable: Any]?, state: TPKeyboardState) -> TPKeyboardInfo
    {
        var beginFrame = CGRect.zero
        (info?[UIResponder.keyboardFrameBeginUserInfoKey] as AnyObject).getValue(&beginFrame)
        
        var endFrame = CGRect.zero
        (info?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).getValue(&endFrame)
        
        let curve = UIView.AnimationCurve(rawValue: info?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int ?? 0) ?? .easeInOut
        let duration = TimeInterval(info?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.0)
        
        return TPKeyboardInfo(beginFrame: beginFrame, endFrame: endFrame, animationCurve: curve, animationDuration: duration, state: state)
    }
}

public extension TPKeyboardInfo
{
    var height: CGFloat
        {
            if state == .willShow || state == .visible
            {
                return endFrame.size.height
            }
            
            return 0
    }
    
    var animationOptions: UIView.AnimationOptions
        {
            switch animationCurve
            {
            case .easeInOut: return UIView.AnimationOptions()
            case .easeIn: return UIView.AnimationOptions.curveEaseIn
            case .easeOut: return UIView.AnimationOptions.curveEaseOut
            case .linear: return UIView.AnimationOptions.curveLinear
            }
    }
}
