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


    public var id : String {
        return self.serial
    }

    var isActivated : Bool {
        return StorageController.shared.loadDeviceActivationStatus(serial: self.serial)
    }

    var activationKey : String {
        return StorageController.shared.loadDeviceActivationKey(model: Int(self.model))
    }

    var batteryPercentage : String {
        return String(battery) + "%"
    }

    var modelName: String {

        switch self.model {
        case 1:
            return "Trapper Express IQ"
        case 2:
            return "Trapper Ambush IQ"
        case 3:
            return "Trapper 24/7 IQ"
        case 4:
            return "Trapper T-Rex IQ"
        default:
            return "Unknown Model"
        }
    }

    var imageName: String {

        switch self.model {
        case 1:
            return "bell_sensing_logo"
        case 2:
            return "bell_sensing_logo"
        case 3:
            return "bell_sensing_logo"
        case 4:
            return "bell_sensing_logo"
        default:
            return "bell_sensing_logo"
        }
    }

    var toDictionary : [String : Any] {
        let mirror = Mirror(reflecting: self)
        let variableList: [(String, Any)] = mirror.children.compactMap {
            guard let label = $0.label else { return nil }
            return (label, $0.value)
        }
        return Dictionary(uniqueKeysWithValues: variableList)
    }

}
