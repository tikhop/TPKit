//
//  UILabel+TPExtension.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 10/09/16.
//
//

import UIKit

extension UILabel
{
    class func labelSnapshot(text: String, font: UIFont, bounds: CGRect) -> UIImage?
    {
        let label = UILabel(frame: bounds)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = font
        label.text = text
        return UIImage.image(from: label)
    }
    
    func imageSnapshot(bounds: CGRect? = nil) -> UIImage?
    {
        guard let r = bounds else
        {
            return UIImage.image(from: self)
        }
        
        return UILabel.labelSnapshot(text: text ?? "", font: font, bounds: r)
    }
}
