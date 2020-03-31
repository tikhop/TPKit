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
        print("URL host:\(String(describing: host))")
        print("URL port:\(String(describing: port))")
        print("URL path:\(path)")
        print("URL fragment:\(String(describing: fragment))")
        print("URL parameterString:\(path)")
        print("URL query:\(String(describing: query))")
        print("URL relativePath:\(relativePath)")
        
        print("URL Path components:")
        pathComponents.forEach
        {
            print($0)
        }
    }
}
