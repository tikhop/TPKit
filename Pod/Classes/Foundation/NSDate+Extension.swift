//
//  NSDate+Extension.swift
//  Alias
//
//  Created by Pavel Tikhonenko on 13/04/15.
//  Copyright (c) 2015 Pavel Tikhonenko. All rights reserved.
//

import Foundation

public extension NSDate
{
    public func isSameDay(date: NSDate) -> Bool
    {
        let calendar = NSCalendar.currentCalendar()
        
        let comp1 = calendar.components([NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Year], fromDate: self)
        let comp2 = calendar.components([NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Year], fromDate: date)
        
        return (comp1.day == comp2.day) && (comp1.month == comp2.month) && (comp1.year == comp2.year)
    }
    
    public func isDateToday() -> Bool
    {
        let otherDay = NSCalendar.currentCalendar().components([.Era, .Year, .Month, .Day], fromDate: self)
        let today = NSCalendar.currentCalendar().components([.Era, .Year, .Month, .Day], fromDate: NSDate())
        
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
    
    public func isDateWithinDaysBefore(days: Int) -> Bool
    {
        let now = NSDate()
        var today:NSDate? = nil;
        
        NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Day, startDate: &today, interval: nil, forDate: now)
        
        let components = NSDateComponents()
        components.day = -days
        
        let beforeDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: today!, options: NSCalendarOptions(rawValue:0))
        
        if(self.compare(beforeDate!) == .OrderedDescending)
        {
            if(self.compare(today!) == .OrderedAscending)
            {
                return true
            }
        }
        
        return false
    }
    
    public class func dateFromString(string: String, dateFormat: String, timeZone: NSTimeZone = NSTimeZone.localTimeZone()) -> NSDate?
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        
        let date = formatter.dateFromString(string)
        return date
    }
    
    public class func formatedStringFromDate(date: NSDate, dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'", timeZone: NSTimeZone = NSTimeZone.localTimeZone()) -> String?
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        
    
        return formatter.stringFromDate(date)
    }
}