//
//  Optional+Extension.swift
//  Sugarfish
//
//  Created by Pavel Tikhonenko on 05/12/15.
//  Copyright © 2015 Pavel Tikhonenko. All rights reserved.
//

import Foundation

extension Optional
{
    func unwrapWithBlock(block: ((some: Wrapped) -> ()))
    {
        switch self
        {
        case .Some(let val):
            block(some: val)
        case .None:
            break
        }
        
    }
}