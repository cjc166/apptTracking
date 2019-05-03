//
//  Reminders.swift
//  apptTracking
//
//  Created by Savita Medlang on 5/2/19.
//  Copyright © 2019 Caleb. All rights reserved.
//

import Foundation
import EventKit


class Reminders{
    
    static func createReminder(title: String, date: NSDate){
        
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .reminder, completion: {
            (accessGranted: Bool, error: Error?) in
            
            if accessGranted == true {
                let reminder: EKReminder! = EKReminder(eventStore: eventStore)
                reminder.title=title
                reminder.startDateComponents = Reminders.dateComponentFromNSDate(date: date) as DateComponents
                reminder.dueDateComponents = Reminders.dateComponentFromNSDate(date: date) as DateComponents
                
                reminder.calendar = eventStore.defaultCalendarForNewReminders()
                let alarm = EKAlarm()
                reminder.addAlarm(alarm)
                do {
                    try eventStore.save(reminder, commit: true)
                }catch{
                    print("Error creating and saving new reminder : \(error)")
                }
            }else{
                print("No access")
            }
        })
    }
    
    static func dateComponentFromNSDate(date: NSDate)-> NSDateComponents{
        print(date)
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(
            [.calendar, .timeZone,
             .era, .quarter,
             .year, .month, .day,
             .hour, .minute, .second, .nanosecond,
             .weekday, .weekdayOrdinal,
             .weekOfMonth, .weekOfYear, .yearForWeekOfYear],
            from: date as Date)
        
        print(dateComponents)
        return dateComponents as NSDateComponents
        
    }
}
