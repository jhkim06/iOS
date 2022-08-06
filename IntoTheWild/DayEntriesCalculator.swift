//
//  DayEntriesCalculator.swift
//  IntoTheWild
//
//  Created by Junho Kim on 2022/08/07.
//

import Foundation

struct DayEntriesCalculator{
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    } ()
    
    static func durationFor(
        date: Date, from regionUpdates: [RegionUpdate]) -> TimeInterval{
            var duration = 0.0
            var enter: RegionUpdate?
            
            for regionUpdate in regionUpdates.reversed() {
                //
                if let unwrappedEnter = enter,
                   regionUpdate.updateType == .exit,
                   Calendar.current.isDate(date, inSameDayAs: regionUpdate.date){
                    duration += unwrappedEnter.date.timeIntervalSince(regionUpdate.date)
                    enter = nil
                } else if regionUpdate.updateType == .enter {
                    enter = regionUpdate
                }
            }
            return duration
        }
    
    static func dayEntries(from regionUpdates: [RegionUpdate]) -> [DayEntry] {
        var dayEntries : [DayEntry] = []
        let now = Date()
        
        for i in 0..<7 {
            if let date = Calendar.current.date(byAdding: .day, value: -i, to: now) {
                let duration = durationFor(date: date, from: regionUpdates)
                
                let weekday = dateFormatter.string(from: date)
                
                dayEntries.append(DayEntry(duration: duration, weekday: weekday))
            }
        }
        return dayEntries.reversed()
    }
}
