//
//  DateExtensions.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/10/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import Foundation

extension NSDate {
    
    /// Returns the year attached to an NSDate object.
    ///
    /// `NSDate().year() -> 2016` (as of writing)
    /// - returns: The year attached to an NSDate object.
    func year() -> Int {
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Year, fromDate: self)
        let year = components.year
        
        return year
    }
    
    /// Returns the month attached to an NSDate object.
    ///
    /// `NSDate().month() -> 8` (as of writing)
    /// - returns: The month attached to an NSDate object.  **Note** that this function returns an Int, not a String!
    func month() -> Int {
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: self)
        let month = components.month
        
        return month
    }
    
    /// Returns the day attached to an NSDate object.
    ///
    /// `NSDate().day() -> 12` (as of writing)
    /// - returns: The day attached to an NSDate object.
    func day() -> Int {
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: self)
        let day = components.day
        
        return day
    }
    
    /// Returns the hour attached to an NSDate object.
    ///
    /// `NSDate().hour() -> 5` (as of writing)
    /// - returns: The hour attached to an NSDate object.
    func hour() -> Int {
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        return hour
    }
    
    /// Returns the minute attached to an NSDate object.
    ///
    /// `NSDate().minute() -> 51` (as of writing)
    /// - returns: The minute attached to an NSDate object.
    func minute() -> Int {
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute
        
        return minute
    }
    
    /// Returns a formatted string of the date attached to an NSDate object.
    /// 
    /// `NSDate().toLongDateString() -> August 12, 2016` (as of writing)
    /// - returns: A formatted string of style NSDateFormatterStyle.LongStyle representing the current date of the NSDate object.
    func toLongDateString() -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        let dateString = formatter.stringFromDate(self)
        
        return dateString
    }
    
    /// Returns a formatted string of the time attached to an NSDate object.
    ///
    /// `NSDate().toShortTimeString() -> 5:51 PM` (as of writing)
    /// - returns: A formatted string of style NSDateFormatterStyle.ShortStyle representing the current time of the NSDate object.
    func toShortTimeString() -> String {
        
        let formatter = NSDateFormatter()
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let timeString = formatter.stringFromDate(self)
        
        return timeString
    }
}