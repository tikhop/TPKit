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
    public class var applicationInfoString: String
    {
        let mainBundle = Bundle.main
    
        let shortVersion = mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let version = mainBundle.object(forInfoDictionaryKey: String(kCFBundleNameKey)) as! String
        let appName = mainBundle.object(forInfoDictionaryKey: String(kCFBundleVersionKey)) as! String
        return "\(appName) \(version)/\(shortVersion)"
    }
    
}
