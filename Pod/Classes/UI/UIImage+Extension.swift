//
//  UIImage+Extension.swift
//  Sugarfish
//
//  Created by PurposeLab on 26/03/15.
//

import UIKit
import CoreGraphics


extension UIImage
{
    func fixRevert() -> UIImage
    {
        if(self.imageOrientation == UIImageOrientation.Up) { return self }
     
        let image = self.CGImage
        
        var transform: CGAffineTransform  = CGAffineTransformIdentity;
        
        switch (self.imageOrientation)
        {
        case .Down, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI));

        case .Left, .LeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2));
            break;
            
        case .Right, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -CGFloat(M_PI_2));
            break;
        case .Up, .UpMirrored:
            break;
        }
        
        switch (self.imageOrientation) {
        case .UpMirrored, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case .LeftMirrored, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
        }

        let width = Int(size.width)
        let height = Int(size.height)
        let bitsPerComponent = CGImageGetBitsPerComponent(image)
        let bytesPerRow = CGImageGetBytesPerRow(image)
        let colorSpace = CGImageGetColorSpace(image)
        let bitmapInfo = CGImageGetBitmapInfo(image)
        
        let context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo.rawValue
        )
        
        CGContextConcatCTM(context, transform)
        switch (self.imageOrientation)
        {
        case UIImageOrientation.Left, UIImageOrientation.LeftMirrored, UIImageOrientation.Right, UIImageOrientation.RightMirrored:
            CGContextDrawImage(context, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(context, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
        }
        
        
        let CGimg = CGBitmapContextCreateImage(context);
        let img = UIImage(CGImage: CGimg!)
        return img
    }
    
    func resizeImageAspectFit(fitWidth: UInt) -> UIImage?
    {
        
        let image = self.CGImage
        
        let factor = CGFloat(CGImageGetWidth(image))/CGFloat(fitWidth)
        
        let width = CGFloat(CGImageGetWidth(image))/factor
        let height = CGFloat(CGImageGetHeight(image))/factor
        let bitsPerComponent = CGImageGetBitsPerComponent(image)
        let bytesPerRow = CGImageGetBytesPerRow(image)
        let colorSpace = CGImageGetColorSpace(image)
        let bitmapInfo = CGImageGetBitmapInfo(image)

        let context = CGBitmapContextCreate(nil, Int(width), Int(height), bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo.rawValue)
        
        CGContextSetInterpolationQuality(context, CGInterpolationQuality.High)
        
        CGContextDrawImage(context, CGRect(origin: CGPointZero, size: CGSize(width: CGFloat(width), height: CGFloat(height))), image)
        
        return UIImage(CGImage: CGBitmapContextCreateImage(context)!)
    }
    
    func resizeImage(size: CGSize) -> UIImage?
    {
        let image = self.CGImage
        
        let width = Int(size.width)
        let height = Int(size.height)
        let bitsPerComponent = CGImageGetBitsPerComponent(image)
        let bytesPerRow = CGImageGetBytesPerRow(image)
        let colorSpace = CGImageGetColorSpace(image)
        let bitmapInfo = CGImageGetBitmapInfo(image)
        
        let context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo.rawValue)
        
        CGContextSetInterpolationQuality(context, CGInterpolationQuality.High)
        
        CGContextDrawImage(context, CGRect(origin: CGPointZero, size: CGSize(width: CGFloat(width), height: CGFloat(height))), image)
        
        return UIImage(CGImage: CGBitmapContextCreateImage(context)!)
    }
}


