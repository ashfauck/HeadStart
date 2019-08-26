//
//  HSArray+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation


extension Array where Element: Equatable
{
    // Remove first collection element that is equal to the given `object`:
    mutating public func remove(object: Element) {
        if let index = firstIndex(of: object)
        {
            remove(at: index)
        }
    }
}

extension Array where Element: Hashable
{
    public var uniqueValues: Set<Element> {
        return Set<Element>(self)
    }
}

extension Array {
    public func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
    
    
    public func find<T: Equatable>(item:T,elements:[T]) -> Int?
    {
        var index:Int = 0
        var found = false
        
        while (index < elements.count && found == false)
        {
            if item == elements[index]
            {
                found = true
            }
            else
            {
                index = index + 1
            }
        }
        
        return found ? index : nil
    }
    
    public func exists<T:Equatable>(item:T,elements:[T]) -> Bool
    {
        var index:Int = 0
        var found = false
        
        while (index < elements.count && found == false)
        {
            if item == elements[index]
            {
                found = true
            }
            else
            {
                index = index + 1
            }
        }
        
        return found
    }
}
