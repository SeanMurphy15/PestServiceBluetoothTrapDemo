//
//  BeaconDataExtensions.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/6/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import Foundation
import BellSensingBLE

extension BeaconData : Identifiable, ObservableObject  {


    var toDictionary : [String : Any] {
        let mirror = Mirror(reflecting: self)
        let variableList: [(String, Any)] = mirror.children.compactMap {
            guard let label = $0.label else { return nil }
            return (label, $0.value)
        }
        return Dictionary(uniqueKeysWithValues: variableList)
    }

}
