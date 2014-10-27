//
//  TimeUtils.swift
//  HTMLHeadbandz
//
//  Created by Paul Yuan on 2014-10-27.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation

class TimeUtils
{
    
    class func PerformAfterDelay(delayInSeconds:Float, completionHandler: () -> Void) {
        var delay:Int64 = Int64(Float(NSEC_PER_SEC) * delayInSeconds)
        var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(popTime, dispatch_get_main_queue(), {() -> Void in
            completionHandler()
        })
    }
    
    class func isToday(date:NSDate) -> Bool {
        var today:NSDate = NSDate()
        var units:NSCalendarUnit = NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.WeekOfYearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.YearCalendarUnit
        var components:NSDateComponents = NSCalendar.currentCalendar().components(units, fromDate: date, toDate: today, options: NSCalendarOptions.allZeros)
        
        if components.year == 0 && components.month == 0 && components.weekOfYear == 0
        {
            if components.day == 0 {
                return true
            }
        }
        
        return false
    }
    
}