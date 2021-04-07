//
//  Date+Extension.swift
//  ZConcept
//
//  Created by AlexeyTolstov on 11/17/19.
//  Copyright © 2019 Stream. All rights reserved.
//

import Foundation

extension Date {

    func toDisplayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let dayString = dateFormatter.string(from: self)
        dateFormatter.dateFormat = "MMMM"
        let mothString = dateFormatter.string(from: self)

        return dayString + " " + mothString.prefix(3)
    }

    func startOfTheDayUTC() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
}
