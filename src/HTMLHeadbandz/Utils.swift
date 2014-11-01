//
//  Utils.swift
//  HTMLHeadbandz
//
//  Created by Paul Yuan on 2014-10-31.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation

class Utils
{
    
    class func shuffle<T>(var list: Array<T>) -> Array<T> {
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    
}