//
//  NSURL+TPExtension.swift
//  Pods
//
//  Created by Pavel Tikhonenko on 07/02/16.
//
//

import Foundation

extension NSURL
{
    public func debug()
    {
        print("URL host:\(host)")
        print("URL port:\(port)")
        print("URL path:\(path)")
        print("URL fragment:\(fragment)")
        print("URL parameterString:\(parameterString)")
        print("URL query:\(query)")
        print("URL relativePath:\(relativePath)")
        
        print("URL Path components:")
        pathComponents?.forEach
        {
            print($0)
        }
    }
}