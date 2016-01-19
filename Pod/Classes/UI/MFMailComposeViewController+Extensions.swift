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
        
        let device = UIDevice.currentDevice()
        let info = "Hardware: \(device.modelName)\nSystem Version: \(device.osVersionName)"
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.setToRecipients([toRecipient])
        mailComposer.setSubject("Feedback on \(UIApplication.applicationInfoString)")
        mailComposer.setMessageBody(info, isHTML: false)
        mailComposer.mailComposeDelegate = self
        return mailComposer
    }
}