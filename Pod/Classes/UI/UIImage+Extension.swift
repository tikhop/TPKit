import UIKit
import CoreGraphics

public enum UIImageScalingMode
{
    case fit
    case fill
    case none
}

public struct UIImageResizeAlignment: OptionSet
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
        if(self.imageOrientation == UIImageOrientation.up) { return self }
        
        var transform: CGAffineTransform  = CGAffineTransform.identity;
        
        switch (self.imageOrientation)
        {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height);
            transform = transform.rotated(by: CGFloat(M_PI));
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0);
            transform = transform.rotated(by: CGFloat(M_PI_2));
            break;
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: -CGFloat(M_PI_2));
            break;
        case .up, .upMirrored:
            break;
        }
        
        switch (self.imageOrientation) {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
            break;
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
            break;
        default:
            break;
        }
        
        let context = bitmapContext(size)
        
        context?.concatenate(transform)
        
        switch (self.imageOrientation)
        {
        case UIImageOrientation.left, UIImageOrientation.leftMirrored, UIImageOrientation.right, UIImageOrientation.rightMirrored:
            context?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width));
            break;
            
        default:
            context?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height));
            break;
        }
        
        let img = UIImage(cgImage: (context?.makeImage()!)!)
        return img
    }
    
    public func resizeImageScaleToFill(_ size: CGSize) -> UIImage?
    {
        return resizeImage(bitmapContext(size), CGRect(origin: CGPoint.zero, size: size))
    }
    
    public func resizeImageAspectFit(_ size: CGSize, alignment: UIImageResizeAlignment = .Center) -> UIImage?
    {
        let imgSize = generateImageSize(.fit, size)
        let point = generateImageOrigin(alignment, size, imgSize)
        
        return resizeImage(bitmapContext(size), CGRect(origin: point, size: imgSize))
    }
    
    
    public func resizeImageAspectFill(_ size: CGSize, alignment: UIImageResizeAlignment = .Center) -> UIImage?
    {
        let imgSize = generateImageSize(.fill, size)
        let point = generateImageOrigin(alignment, size, imgSize)
        
        return resizeImage(bitmapContext(size), CGRect(origin: point, size: imgSize))
    }
    
    fileprivate func resizeImage(_ context: CGContext?, _ rect: CGRect) -> UIImage?
    {
        context!.interpolationQuality = CGInterpolationQuality.high
        context?.draw(image!, in: rect)
        
        if let img = context?.makeImage()
        {
            return UIImage(cgImage: img)
        }else{
            return nil
        }
    }
    
    fileprivate func bitmapContext(_ size: CGSize) -> CGContext?
    {
        let width = Int(size.width)
        let height = Int(size.height)
        let bitsPerComponent = image?.bitsPerComponent
        let bytesPerRow = width*4
        let colorSpace = image?.colorSpace
        let bitmapInfo = image?.bitmapInfo
        
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent!, bytesPerRow: bytesPerRow, space: colorSpace!, bitmapInfo: (bitmapInfo?.rawValue)!)
        return context
    }
    
    //TODO: implement this algorith using two division rather than three
    fileprivate func generateImageSize(_ scaleMode: UIImageScalingMode, _ containerSize: CGSize) -> CGSize
    {
        var f: (CGFloat, CGFloat) -> Bool
        
        switch(scaleMode)
        {
        case .fill: f = (<)
        case .fit: f = (>)
        case .none: return containerSize
        }
        
        let realWidth = CGFloat((image?.width)!)
        let realHeight = CGFloat((image?.height)!)
        let realFactor = realWidth/realHeight
        
        let width = containerSize.width
        let height = containerSize.height
        let factor = width/height
        
        let newWidth = f(factor, realFactor) ? realWidth * height/realHeight : width
        let newHeight = f(factor, realFactor) ? height : realHeight * width/realWidth
        
        return CGSize(width: newWidth, height: newHeight)
    }
    
    fileprivate func generateImageOrigin(_ alignment: UIImageResizeAlignment, _ containerSize: CGSize, _ imageSize: CGSize) -> CGPoint
    {
        var point = CGPoint.zero
        
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
    
    fileprivate var image: CGImage?
    {
            return self.cgImage
    }
}


