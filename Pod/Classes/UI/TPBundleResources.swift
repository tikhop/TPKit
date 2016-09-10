//
//  TPBundleResources.swift
//
//  Created by PurposeLab on 20/07/2014.
//

var kMainStoryboardName: String {
    let info = Bundle.main.infoDictionary!
    
    if let value = info["TPMainStoryboardName"] as? String
    {
        return value
    }else{
        return "Main"
    }
}

open class TPBundleResources
{
    open class func nib(_ name: String) -> UINib?
    {
        let nib = UINib(nibName: name, bundle: Bundle.main);
        return nib
    }
    
    //Main storybord
    open class func mainStoryboard() -> UIStoryboard
    {
        return storyboard(kMainStoryboardName)
    }
    
    open class func storyboard(_ name: String) -> UIStoryboard
    {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard
    }
    
    //Obtain file from main bundle by name and fileType
    open class func fileFromBundle(_ fileName: String?, fileType: String?) -> URL?
    {
        var url: URL?
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType)
        {
            url = URL(fileURLWithPath: path)
        }
        
        return url
    }
    
    open class func plistValue(_ key:String) -> AnyObject?
    {
        let info = Bundle.main.infoDictionary!
        
        if let value: AnyObject = info[key] as AnyObject?
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
    class func vcWithName(_ name: String) -> UIViewController?
    {
        let storyboard = mainStoryboard()
        let viewController: AnyObject! = storyboard.instantiateViewController(withIdentifier: name)
        return viewController as? UIViewController
    }
    
    class func vcWithName(_ storyboardName:String, name: String) -> UIViewController?
    {
        let sb = storyboard(storyboardName)
        let viewController: AnyObject! = sb.instantiateViewController(withIdentifier: name)
        return viewController as? UIViewController
    }
    
    //Obtain view by idx from nib
    class func viewFromNib(_ nibName: String, atIdx idx:Int) -> UIView?
    {
        let view =  Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?[idx] as! UIView
        return view
    }
    
    class func viewFromNib(_ nibName: String, owner: AnyObject, atIdx idx:Int) -> UIView?
    {
        let bundle = Bundle(for: type(of: owner))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: owner, options: nil)[idx] as? UIView
        return view
    }
    
    class func viewFromNibV2(_ nibName: String, owner: AnyObject, atIdx idx:Int) -> UIView?
    {
        let view =  Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)?[idx] as! UIView
        return view
    }
}
