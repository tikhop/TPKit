import UIKit
import CoreGraphics

public enum UIImageScalingMode
{
    case Fit
    case Fill
    case None
}

public struct UIImageResizeAlignment: OptionSetType
{
    public let rawValue : UInt
    public init(rawValue: UInt) { self.rawValue = rawValue }
    
    public static let Center = UIImageResizeAlignment(rawValue: UInt(1 << 0))
    public static let Top = UIImageResizeAlignment(rawValue: UInt(1 << 1))
    public static let Bottom = UIImageResizeAlignment(rawValue: UInt(1 << 2))
    public static let Left = UIImageResizeAlignment(rawValue: UInt(1 << 3))
    public static let Right = UIImageResizeAlignment(rawValue: UInt(1 << 4))
}

public extension UIImage
{
    public func color() -> UIColor
    {
        return UIColor(patternImage: self)
    }
    
    public func fixRevert() -> UIImage
    {
        if(self.imageOrientation == UIImageOrientation.Up) { return self }
        
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
        
        let context = bitmapContext(size)
        
        CGContextConcatCTM(context, transform)
        
        switch (self.imageOrientation)
        {
        case UIImageOrientation.Left, UIImageOrientation.LeftMirrored, UIImageOrientation.Right, UIImageOrientation.RightMirrored:
            CGContextDrawImage(context, CGRectMake(0, 0, self.size.height, self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(context, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
            break;
        }
        
        let img = UIImage(CGImage: CGBitmapContextCreateImage(context)!)
        return img
    }
    
    public func resizeImageScaleToFill(size: CGSize) -> UIImage?
    {
        return resizeImage(bitmapContext(size), CGRect(origin: CGPointZero, size: size))
    }
    
    public func resizeImageAspectFit(size: CGSize, alignment: UIImageResizeAlignment = .Center) -> UIImage?
    {
        let imgSize = generateImageSize(.Fit, size)
        let point = generateImageOrigin(alignment, size, imgSize)
        
        return resizeImage(bitmapContext(size), CGRect(origin: point, size: imgSize))
    }
    
    
    public func resizeImageAspectFill(size: CGSize, alignment: UIImageResizeAlignment = .Center) -> UIImage?
    {
        let imgSize = generateImageSize(.Fill, size)
        let point = generateImageOrigin(alignment, size, imgSize)
        
        return resizeImage(bitmapContext(size), CGRect(origin: point, size: imgSize))
    }
    
    private func resizeImage(context: CGContext?, _ rect: CGRect) -> UIImage?
    {
        CGContextSetInterpolationQuality(context, CGInterpolationQuality.High)
        CGContextDrawImage(context, rect, image)
        
        if let img = CGBitmapContextCreateImage(context)
        {
            return UIImage(CGImage: img)
        }else{
            return nil
        }
    }
    
    private func bitmapContext(size: CGSize) -> CGContext?
    {
        let width = Int(size.width)
        let height = Int(size.height)
        let bitsPerComponent = CGImageGetBitsPerComponent(image)
        let bytesPerRow = width*4
        let colorSpace = CGImageGetColorSpace(image)
        let bitmapInfo = CGImageGetBitmapInfo(image)
        
        let context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo.rawValue)
        return context
    }
    
    //TODO: implement this algorith using two division rather than three
    private func generateImageSize(scaleMode: UIImageScalingMode, _ containerSize: CGSize) -> CGSize
    {
        var f: (CGFloat, CGFloat) -> Bool
        
        switch(scaleMode)
        {
        case .Fill: f = (<)
        case .Fit: f = (>)
        case .None: return containerSize
        }
        
        let realWidth = CGFloat(CGImageGetWidth(image))
        let realHeight = CGFloat(CGImageGetHeight(image))
        let realFactor = realWidth/realHeight
        
        let width = containerSize.width
        let height = containerSize.height
        let factor = width/height
        
        let newWidth = f(factor, realFactor) ? realWidth * height/realHeight : width
        let newHeight = f(factor, realFactor) ? height : realHeight * width/realWidth
        
        return CGSize(width: newWidth, height: newHeight)
    }
    
    private func generateImageOrigin(alignment: UIImageResizeAlignment, _ containerSize: CGSize, _ imageSize: CGSize) -> CGPoint
    {
        var point = CGPointZero
        
        if alignment.contains(.Center)
        {
            point.x = (containerSize.width - imageSize.width)/2
            point.y = (containerSize.height - imageSize.height)/2
        }
        
        if alignment.contains(.Top)
        {
            point.y = containerSize.height - imageSize.height
        }
        
        if alignment.contains(.Bottom)
        {
            point.y =  0
        }
        
        if alignment.contains(.Left)
        {
            point.x = 0
        }
        
        if alignment.contains(.Right)
        {
            point.x = containerSize.width - imageSize.width
        }
        
        return point
    }
    
    private var image: CGImageRef?
    {
            return self.CGImage
    }
}


