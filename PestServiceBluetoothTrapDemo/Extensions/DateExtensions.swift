//
//  DateExtensions.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/20/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import Foundation

extension Date {

    func toGMTDateString() -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let formattedDate = formatter.string(from: self)
        return formattedDate
    }
}
