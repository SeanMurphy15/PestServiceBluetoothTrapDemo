//
//  TrapDetection.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/21/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import Foundation

class TrapDetection : Identifiable, ObservableObject {

    var signature : String
    var time : Date?
    var dictionary : [String:Any] = [:]

    init(object: [String : Any]) {
        self.signature = object["signature"] as? String ?? "0"
        self.time = object["time"] as? Date
        self.dictionary["Date"] = time?.toGMTDateString()
        self.dictionary["SensorSignature"] = self.signature

    }

}
