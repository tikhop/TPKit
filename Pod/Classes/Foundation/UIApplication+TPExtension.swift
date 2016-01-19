//
//  UIApplication+TPExtension.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 18/01/16.
//
//

import UIKit

public extension UIApplication
{
    class var applicationInfoString: String
    {
        let mainBundle = NSBundle.mainBundle()
    
        let shortVersion = mainBundle.objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        let version = mainBundle.objectForInfoDictionaryKey(String(kCFBundleNameKey)) as! String
        let appName = mainBundle.objectForInfoDictionaryKey(String(kCFBundleVersionKey)) as! String
        return "\(appName) \(version)/\(shortVersion)"
    }
    
}