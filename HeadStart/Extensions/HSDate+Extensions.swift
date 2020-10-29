//
//  HSDate+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation

extension Date
{
    public func toString(with dateFormatter:DateFormatter) -> String?
    {
        return dateFormatter.string(from: self)
    }
    
    public func toString(dateFormat: String,timezone:TimeZone? = nil) -> String
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale.current
        
        if let timeZ = timezone
        {
            dateFormatter.timeZone = timeZ
        }
        else
        {
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        }
        
        dateFormatter.dateFormat = dateFormat
        
        return (dateFormatter.string(from: self))
    }
    
    public func currentDate(dateFormat:String) -> String
    {
       let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = dateFormat
        
        return (dateFormatter.string(from: self))
    }
    
    public func getComponents(component: Set<Calendar.Component>) -> DateComponents
    {
        return Calendar.current.dateComponents(component, from: self)
    }
    
    public var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    public func local() -> Date
    {
        let nowUTC = Date()
        
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        
        return localDate
    }
    
    public func localTime() -> Date
    {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    public func timeStamp() -> Int
    {
        return Int(self.timeIntervalSince1970)
    }
}
