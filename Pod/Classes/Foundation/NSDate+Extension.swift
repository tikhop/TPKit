//
//  NSDate+Extension.swift
//  Alias
//
//  Created by Pavel Tikhonenko on 13/04/15.
//  Copyright (c) 2015 Pavel Tikhonenko. All rights reserved.
//

import Foundation

extension NSDate
{
    func isSameDay(date: NSDate) -> Bool
    {
        let calendar = NSCalendar.currentCalendar()
        
        let comp1 = calendar.components([.NSMonthCalendarUnit, .NSDayCalendarUnit, .NSYearCalendarUnit], fromDate: self)
        let comp2 = calendar.components([.NSMonthCalendarUnit, .NSDayCalendarUnit, .NSYearCalendarUnit], fromDate: date)
        
        return (comp1.day == comp2.day) && (comp1.month == comp2.month) && (comp1.year == comp2.year)
    }
    
    func isDateToday() -> Bool
    {
        let otherDay = NSCalendar.currentCalendar().components([.Era, .Year, .Month, .Day], fromDate: self)
        let today = NSCalendar.currentCalendar().components([.Era, .Year, .Month, .Day], fromDate: NSDate())
        
        let isToday = (today.day == otherDay.day &&
            today.month == otherDay.month &&
            today.year == otherDay.year &&
            today.era == otherDay.era)
        return isToday
    }
    
    func isDateWithinWeek() -> Bool
    {
        return isDateWithinDaysBefore(7)
    }
    
    func isDateWithinDaysBefore(days: Int) -> Bool
    {
        let now = NSDate()
        var today:NSDate? = nil;
        
        NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.NSDayCalendarUnit, startDate: &today, interval: nil, forDate: now)
        
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
    
    class func dateFromString(string: String, dateFormat: String, timeZoneAbbreviation: String = "UTC") -> NSDate?
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = NSTimeZone(abbreviation: timeZoneAbbreviation)
        
        let date = formatter.dateFromString(string)
        return date
    }
    
    class func formatedStringFromDate(date: NSDate, dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'", timeZoneAbbreviation: String = "UTC") -> String?
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = NSTimeZone(abbreviation: "UTC")
    
        return formatter.stringFromDate(date)
    }
}