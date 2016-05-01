//
//  Created by Pavel Tikhonenko on 04/12/15.
//  Copyright © 2015 Pavel Tikhonenko. All rights reserved.
//

import Foundation

public extension SequenceType
{
    public func generatePairs() -> [(Self.Generator.Element, Self.Generator.Element?)]
    {
        var result:[(Self.Generator.Element, Self.Generator.Element?)] = []
        var pair:(Self.Generator.Element, Self.Generator.Element?)!
        
        for (i, item) in self.enumerate()
        {
            if i%2 == 0
            {
                pair = (item, nil)
            }else{
                pair.1 = item
                result.append(pair)
            }
        }
        
        if result.count != Int(round(Float(self.underestimateCount())/2.0))
        {
            result.append(pair)
        }
        
        return result
    }
    
}

public extension Array
{
    public var decompose:(head: Element, tail: [Element])?
    {
        return isEmpty ? nil : (self[0], Array(self[1..<count]))
    }
}
