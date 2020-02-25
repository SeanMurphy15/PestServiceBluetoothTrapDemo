//
//  TrapDetection.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/21/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import Foundation

protocol Dated {
    var date: Date { get }
}

extension Array where Element: Dated {
    func groupedBy(dateComponents: Set<Calendar.Component>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents(dateComponents, from: cur.date)
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }

        return groupedByDateComponents
    }
}

class TrapDetection : Identifiable, ObservableObject, Dated, Equatable {

    var signature : String
    var date : Date
    var dictionary : [String:Any] = [:]

    init(object: [String : Any]) {
        self.signature = object["signature"] as? String ?? "0"
        self.date = object["time"] as? Date ?? Date()
        self.dictionary["Date"] = date.toGMTDateString()
        self.dictionary["SensorSignature"] = self.signature

    }

    static func == (lhs: TrapDetection, rhs: TrapDetection) -> Bool {
        return lhs.date == rhs.date

    }
}
