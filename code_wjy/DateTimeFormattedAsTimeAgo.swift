//
//  DateTimeFormattedAsTimeAgo.swift
//  Swift Time Ago
//
//  Created by Julien Colin on 4/17/15.
//  Copyright (c) 2015 Toldino. All rights reserved.
//
import Foundation

public func dateTimeFormattedAsTimeAgo(date: Date, referenceDate now: Date = Date()) -> String {
    
    let secondsFromDate = now.secondsFrom(date: date)
    if secondsFromDate < 60 {
        return secondsFormatter()
    }
    
    let minutesFromDate = now.minutesFrom(date: date)
    if minutesFromDate < 60 {
        return minutesFormatter(minutes: minutesFromDate)
    }
    
    let hoursFromDate = now.hoursFrom(date: date)
    if hoursFromDate < 24 {
        return hoursFormatter(hours: hoursFromDate)
    }
    
    let daysFromDate = now.daysFrom(date: date)
    switch daysFromDate {
    case 1:
        return yesterdayFormatter()
    case 2...6:
        return daysFormatter(days: daysFromDate)
    default:
        break
    }
    
    let weeksFromDate = now.weeksFrom(date: date)
    let monthsFromDate = now.monthsFrom(date: date)
    switch monthsFromDate {
    case 0:
        return weeksFormatter(weeks: weeksFromDate)
    case 1...11:
        return monthsFormatter(months: monthsFromDate)
    default:
        break
    }
    
    let yearsFromDate = now.yearsFrom(date: date)
    return yearsFormatter(years: yearsFromDate)
}

// MARK: Formatter functions
func classicFormatterAgo(quantity: Int, unit: String) -> String {
    var formattedString = "\(quantity) \(unit)"
    if quantity > 1 {
        formattedString += "s"
    }
    formattedString += " ago"
    return formattedString
}

func secondsFormatter() -> String {
    return "Just now"
}

func minutesFormatter(minutes: Int) -> String {
    return classicFormatterAgo(quantity: minutes, unit: "minute")
}

func hoursFormatter(hours: Int) -> String {
    return classicFormatterAgo(quantity: hours, unit: "hour")
}

func yesterdayFormatter() -> String {
    return "Yesterday"
}

func daysFormatter(days: Int) -> String {
    return classicFormatterAgo(quantity: days, unit: "day")
}

func weeksFormatter(weeks: Int) -> String {
    return classicFormatterAgo(quantity: weeks, unit: "week")
}

func monthsFormatter(months: Int) -> String {
    return classicFormatterAgo(quantity: months, unit: "month")
}

func yearsFormatter(years: Int) -> String {
    return classicFormatterAgo(quantity: years, unit: "year")
}

// MARK: Extension of NSDate
private extension Date {
    func yearsFrom(date:Date) -> Int{
        return Calendar.current.component(.year, from: date)
    }
    func monthsFrom(date:Date) -> Int{
        return Calendar.current.component(.month, from: date)
    }
    func weeksFrom(date:Date) -> Int{
        return Calendar.current.component(.weekOfYear, from: date)
    }
    func daysFrom(date:Date) -> Int{
        return Calendar.current.component(.day, from: date)
    }
    func hoursFrom(date:Date) -> Int{
        return Calendar.current.component(.hour, from: date)
    }
    func minutesFrom(date:Date) -> Int{
        return Calendar.current.component(.minute, from: date)
    }
    func secondsFrom(date:Date) -> Int{
        return Calendar.current.component(.second, from: date)
    }
}
