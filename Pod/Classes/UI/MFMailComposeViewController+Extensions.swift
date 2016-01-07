//
//  MFMailComposeViewController+Extensions.swift
//  Alias
//
//  Created by Pavel Tikhonenko on 21/05/15.
//  Copyright (c) 2015 Pavel Tikhonenko. All rights reserved.
//

import MessageUI
import UIKit

extension UIViewController: MFMailComposeViewControllerDelegate
{
    public func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createReportAProblemVC(toRecipient: String) -> MFMailComposeViewController?
    {
        if !MFMailComposeViewController.canSendMail() { return nil }
        
        let mainBundle = NSBundle.mainBundle()
        let device = UIDevice.currentDevice()
        
        let shortVersion = mainBundle.objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        let version = mainBundle.objectForInfoDictionaryKey(String(kCFBundleNameKey)) as! String
        var appName = mainBundle.objectForInfoDictionaryKey(String(kCFBundleVersionKey)) as! String
        appName = "\(appName) \(version)/\(shortVersion)"
        
        let info = "Hardware: \(device.model)\nSystem Version: \(device.systemName) \(device.systemVersion)"
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.setToRecipients([toRecipient])
        mailComposer.setSubject("Feedback on \(appName)")
        mailComposer.setMessageBody(info, isHTML: false)
        mailComposer.mailComposeDelegate = self
        return mailComposer
    }
}