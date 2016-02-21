//
//  TPBundleResources.swift
//
//  Created by PurposeLab on 20/07/2014.
//

var kMainStoryboardName: String {
    let info = NSBundle.mainBundle().infoDictionary!
    
    if let value = info["TPMainStoryboardName"] as? String
    {
        return value
    }else{
        return "Main"
    }
}

public class TPBundleResources
{
    class func nib(name: String) -> UINib?
    {
        let nib = UINib(nibName: name, bundle: NSBundle.mainBundle());
        return nib
    }
    
    //Main storybord
    class func mainStoryboard() -> UIStoryboard
    {
        return storyboard(kMainStoryboardName)
    }
    
    class func storyboard(name: String) -> UIStoryboard
    {
        let storyboard = UIStoryboard(name: name, bundle: NSBundle.mainBundle())
        return storyboard
    }
    
    //Obtain file from main bundle by name and fileType
    class func fileFromBundle(fileName: String?, fileType: String?) -> NSURL?
    {
        var url: NSURL?
        
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
        {
            url = NSURL.fileURLWithPath(path)
        }
        
        return url
    }
    
    class func plistValue(key:String) -> AnyObject?
    {
        let info = NSBundle.mainBundle().infoDictionary!
        
        if let value: AnyObject = info[key]
        {
            return value
        }else{
            return nil
        }
    }
}


public extension TPBundleResources
{
    //Obtain view controller by name from main storyboard
    class func vcWithName(name: String) -> UIViewController?
    {
        let storyboard = mainStoryboard()
        let viewController: AnyObject! = storyboard.instantiateViewControllerWithIdentifier(name)
        return viewController as? UIViewController
    }
    
    class func vcWithName(storyboardName:String, name: String) -> UIViewController?
    {
        let sb = storyboard(storyboardName)
        let viewController: AnyObject! = sb.instantiateViewControllerWithIdentifier(name)
        return viewController as? UIViewController
    }
    
    //Obtain view by idx from nib
    class func viewFromNib(nibName: String, atIdx idx:Int) -> UIView?
    {
        let view =  NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)[idx] as! UIView
        return view
    }
    
    class func viewFromNib(nibName: String, owner: AnyObject, atIdx idx:Int) -> UIView?
    {
        let bundle = NSBundle(forClass: owner.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(owner, options: nil)[idx] as? UIView
        return view
    }
    
    class func viewFromNibV2(nibName: String, owner: AnyObject, atIdx idx:Int) -> UIView?
    {
        let view =  NSBundle.mainBundle().loadNibNamed(nibName, owner: owner, options: nil)[idx] as! UIView
        return view
    }
}