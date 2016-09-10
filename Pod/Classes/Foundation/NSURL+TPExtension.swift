//
//  NSURL+TPExtension.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 07/02/16.
//
//

import Foundation

extension URL
{
    public func debug()
    {
        print("URL host:\(host)")
        print("URL port:\(port)")
        print("URL path:\(path)")
        print("URL fragment:\(fragment)")
        print("URL parameterString:\(path)")
        print("URL query:\(query)")
        print("URL relativePath:\(relativePath)")
        
        print("URL Path components:")
        pathComponents.forEach
        {
            print($0)
        }
    }
}
