//
//  HSDateFormatter+Extensions.swift
//  HeadStart
//
//  Created by Ashfauck on 3/22/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import Foundation


public enum DateFormat : String
{
    case fullFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case ddMMyyyyFormat = "dd/MM/yyyy"
    case ddMMyyyyHHmmFormat = "dd/MM/yyyy HH:mm"
    case yyyyMMddFormat = "yyyy-MM-dd"
    case MMMddyyhhmmaFormat = "MMM dd yy hh:mm a"
    case EEEEddMMyyAthhmmFormat = "EEEE dd/MM/yy at hh:mm a"
    case readableDate = "EEEE MMMM dd, yyyy"
    case timeFormat = "HH:mm"
    case monthDate = "MMM dd yyyy"
    case displayTimeFormat = "h:mm a"
    case fullWithZFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case monthDateFormat = "MMM"
    case dayFormat = "dd"
    case ddMMMyyyyFormat = "dd-MMM-yyyy"
    case ddMMyyyyHyphenFormat = "dd-MM-yyyy"
}


extension DateFormatter
{
    public static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.fullFormat.rawValue
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = Locale.current
        return formatter
    }()
    
    public static let ddMMyyyyDateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = DateFormat.ddMMyyyyFormat.rawValue
        return dateFormatter
    }()
    
    public static let ddMMyyyyHyphenDateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = DateFormat.ddMMyyyyHyphenFormat.rawValue
        return dateFormatter
    }()
    
    public static let yyyyMMddDateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = DateFormat.yyyyMMddFormat.rawValue
        return dateFormatter
    }()
    
    public static let MMMddyyhhmmaDateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = DateFormat.MMMddyyhhmmaFormat.rawValue
        
        return dateFormatter
    }()
    
    public static let EEEEddMMyyAthhmmDateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = DateFormat.EEEEddMMyyAthhmmFormat.rawValue
        return dateFormatter
    }()
    
    public static let readableDateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = DateFormat.readableDate.rawValue
        return dateFormatter
    }()
    
    public static let timeDateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = DateFormat.timeFormat.rawValue
        return dateFormatter
    }()
    
    public static let monthDateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = DateFormat.monthDate.rawValue
        return dateFormatter
    }()
    
    public static let ddMMyyyyHHmmFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = DateFormat.ddMMyyyyHHmmFormat.rawValue
        return dateFormatter
    }()
    
    
    
    public static let displayTimeFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = DateFormat.displayTimeFormat.rawValue
        return dateFormatter
    }()
    
    public static let fullWithZFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = DateFormat.fullWithZFormat.rawValue
        return dateFormatter
    }()
    
    public static let monthFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = DateFormat.monthDateFormat.rawValue
        return dateFormatter
    }()
    
    public static let dayFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = DateFormat.dayFormat.rawValue
        return dateFormatter
    }()
    
    public static let ddMMMyyyyDateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = DateFormat.ddMMMyyyyFormat.rawValue
        return dateFormatter
    }()
    
    public static let MMddyyyyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = Locale.current
        return formatter
    }()
    
    public static let yyyyMMddHHmmssDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = Locale.current
        return formatter
    }()
    
    public static let MMddyyyyHyphenDateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter
    }()

    public static let MMMddyyyyFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        return dateFormatter
    }()
}



