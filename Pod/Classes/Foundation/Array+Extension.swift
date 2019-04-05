//
//  Created by Pavel Tikhonenko on 04/12/15.
//  Copyright © 2015 Pavel Tikhonenko. All rights reserved.
//

import Foundation

public extension Sequence
{
    func generatePairs() -> [(Self.Iterator.Element, Self.Iterator.Element?)]
    {
        var result:[(Self.Iterator.Element, Self.Iterator.Element?)] = []
        var pair:(Self.Iterator.Element, Self.Iterator.Element?)!
        
        for (i, item) in self.enumerated()
        {
            if i%2 == 0
            {
                pair = (item, nil)
            }else{
                pair.1 = item
                result.append(pair)
            }
        }
        
        if result.count != Int(round(Float(self.underestimatedCount)/2.0))
        {
            result.append(pair)
        }
        
        return result
    }
    
}

public extension Array
{
    var decompose:(head: Element, tail: [Element])?
    {
        return isEmpty ? nil : (self[0], Array(self[1..<count]))
    }
}
