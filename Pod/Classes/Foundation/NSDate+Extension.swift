//
//  NSDate+Extension.swift
//  Alias
//
//  Created by Pavel Tikhonenko on 13/04/15.
//  Copyright (c) 2015 Pavel Tikhonenko. All rights reserved.
//

import Foundation

public extension Date
{
    public func isSameDay(_ date: Date) -> Bool
    {
        let calendar = Calendar.current
        
        let comp1 = (calendar as NSCalendar).components([NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.year], from: self)
        let comp2 = (calendar as NSCalendar).components([NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.year], from: date)
        
        return (comp1.day == comp2.day) && (comp1.month == comp2.month) && (comp1.year == comp2.year)
    }
    
    public func isDateToday() -> Bool
    {
        let otherDay = (Calendar.current as NSCalendar).components([.era, .year, .month, .day], from: self)
        let today = (Calendar.current as NSCalendar).components([.era, .year, .month, .day], from: Date())
        
        let isToday = (today.day == otherDay.day &&
            today.month == otherDay.month &&
            today.year == otherDay.year &&
            today.era == otherDay.era)
        return isToday
    }
    
    public func isDateWithinWeek() -> Bool
    {
        return isDateWithinDaysBefore(7)
    }
    
    public func isDateWithinDaysBefore(_ days: Int) -> Bool
    {
        let now = Date()
        var today:Date? = nil;
        
        (Calendar.current as NSCalendar).range(of: NSCalendar.Unit.day, start: &today, interval: nil, for: now)
        
        var components = DateComponents()
        components.day = -days
        
        let beforeDate = (Calendar.current as NSCalendar).date(byAdding: components, to: today!, options: NSCalendar.Options(rawValue:0))
        
        if(self.compare(beforeDate!) == .orderedDescending)
        {
            if(self.compare(today!) == .orderedAscending)
            {
                return true
            }
        }
        
        return false
    }
    
    public static func dateFromString(_ string: String, dateFormat: String, timeZone: TimeZone = TimeZone.autoupdatingCurrent) -> Date?
    {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        
        let date = formatter.date(from: string)
        return date
    }
    
    public static func formatedStringFromDate(_ date: Date, dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'", timeZone: TimeZone = TimeZone.autoupdatingCurrent) -> String?
    {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        
    
        return formatter.string(from: date)
    }
}
