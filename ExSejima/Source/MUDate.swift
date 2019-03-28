//
//  MUDate.swift
//  ExSejima
//
//  Created by Loïc GRIFFIE on 28/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import Foundation

extension Date {
    /// Date from now with updated component(s).
    ///
    ///     Date(day: -1) // Yesterday at the same hour/minute
    ///     Date(year: 1) // Next year at the same day/month
    ///
    /// - Parameters:
    /// - year:         The year to add.
    /// - month:        The month to add.
    /// - day:          The day to add.
    /// - hour:         The hour to add.
    /// - minute:       The minute to add.
    /// - second:       The second to add.
    ///
    /// - Returns: a Date.
    public init(year: Int? = nil,
                month: Int? = nil,
                day: Int? = nil,
                hour: Int? = nil,
                minute: Int? = nil,
                second: Int? = nil) {
        let now = Date()
        let calendar = Calendar.current

        var components = DateComponents()
        components.year = calendar.component(.year, from: now) + (year ?? 0)
        components.month = calendar.component(.month, from: now) + (month ?? 0)
        components.day = calendar.component(.day, from: now) + (day ?? 0)
        components.hour = calendar.component(.hour, from: now) + (hour ?? 0)
        components.minute = calendar.component(.minute, from: now) + (minute ?? 0)
        components.second = calendar.component(.second, from: now) + (second ?? 0)

        guard let date = calendar.date(from: components) else {
            self = Date()
            return
        }

        self = date
    }

    /// Date string from date.
    ///
    ///     Date().string(withFormat: "dd/MM/yyyy") -> "1/12/17"
    ///     Date().string(withFormat: "HH:mm") -> "23:50"
    ///     Date().string(withFormat: "dd/MM/yyyy HH:mm") -> "1/12/17 23:50"
    ///
    /// - Parameter format: Date format (default is "dd/MM/yyyy").
    /// - Returns: date string.
    public func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    /// Date string from date.
    ///
    ///     Date().dateString(ofStyle: .short) -> "1/12/17"
    ///     Date().dateString(ofStyle: .medium) -> "Jan 12, 2017"
    ///     Date().dateString(ofStyle: .long) -> "January 12, 2017"
    ///     Date().dateString(ofStyle: .full) -> "Thursday, January 12, 2017"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: date string.
    public func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }

    /// Date and time string from date.
    ///
    ///     Date().dateTimeString(ofStyle: .short) -> "1/12/17, 7:32 PM"
    ///     Date().dateTimeString(ofStyle: .medium) -> "Jan 12, 2017, 7:32:00 PM"
    ///     Date().dateTimeString(ofStyle: .long) -> "January 12, 2017 at 7:32:00 PM GMT+3"
    ///     Date().dateTimeString(ofStyle: .full) -> "Thursday, January 12, 2017 at 7:32:00 PM GMT+03:00"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: date and time string.
    public func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }

    /// Time string from date
    ///
    ///     Date().timeString(ofStyle: .short) -> "7:37 PM"
    ///     Date().timeString(ofStyle: .medium) -> "7:37:02 PM"
    ///     Date().timeString(ofStyle: .long) -> "7:37:02 PM GMT+3"
    ///     Date().timeString(ofStyle: .full) -> "7:37:02 PM GMT+03:00"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: time string.
    public func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: self)
    }

    /// Get number of years between two date.
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of years between self and given date.
    public func yearsSince(_ date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }

    /// Check if date is within today.
    ///
    ///     Date().isToday -> true
    ///
    public var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    /// Generate intervale of date from midnight to midnight net day.
    ///
    ///     Date().dayInterval(for: 31-01-2019 15:34:13) -> (start: 31-01-2019 00:00:00, end: 31-01-2019 23:59:59)
    ///
    public func dayInterval(for date: Date) -> (start: Date, end: Date) {
        let start = Calendar.current.startOfDay(for: date)
        guard let end: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: start)
            }() else {
                return (start: date, end: date)
        }

        return (start, end)
    }
}

extension TimeInterval {
    /// TimeInterval for one second.
    public static var second: TimeInterval = {
        return 1
    }()

    /// TimeInterval for one minute (in seconds).
    public static var minute: TimeInterval = {
        return 60 * .second
    }()

    /// TimeInterval for one hour (in seconds).
    public static var hour: TimeInterval = {
        return 60 * .minute
    }()

    /// TimeInterval for one day (in seconds).
    public static var day: TimeInterval = {
        return 24 * .hour
    }()
}
