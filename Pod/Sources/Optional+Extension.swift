//
//  Created by Pavel Tikhonenko on 05/12/15.
//  Copyright © 2015 Pavel Tikhonenko. All rights reserved.
//

import Foundation

public extension Optional
{
    func unwrapWithBlock(_ block: ((_ some: Wrapped) -> ()))
    {
        switch self
        {
        case .some(let val):
            block(val)
        case .none:
            break
        }
        
    }
}
