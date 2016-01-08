//
//  UIColor+Extension.swift
//  Alias
//
//  Created by Pavel Tikhonenko on 22/03/15.
//  Copyright (c) 2015 Pavel Tikhonenko. All rights reserved.
//

import UIKit

public  extension UIColor
{
    class func imageFromColor(color:UIColor) -> UIImage
    {
        return imageFromColor(color, width:1, height:1)
    }
    
    class func imageFromColor(color:UIColor, width:CGFloat, height:CGFloat) -> UIImage
    {
        let rect = CGRectMake(0, 0, width, height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    class func hexColor(color: Int32) -> UIColor
    {
        let r = CGFloat((color >> 16)&0xFF)/255.0
        let g = CGFloat((color >> 8)&0xFF)/255.0
        let b = CGFloat(color&0xFF)/255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    convenience init(red: Int, green: Int, blue: Int)
    {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int)
    {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}
