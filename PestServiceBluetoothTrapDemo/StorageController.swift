//
//  StorageController.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/5/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import Foundation

class StorageController {

    static let siteId = UUID(uuidString: "96b3b257-afcc-482d-aea7-a069f5329934")!

    static func deviceCache() -> UserDefaults {

        if let defaults = UserDefaults(suiteName: siteId.uuidString) {
            return defaults
        } else {
            return UserDefaults.init(suiteName: siteId.uuidString)!
        }
    }
    
}
