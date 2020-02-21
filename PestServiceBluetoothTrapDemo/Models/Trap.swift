//
//  Trap.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/20/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import Foundation
import SwiftUI
import BellSensingBLE


class Trap : Identifiable, ObservableObject {

    public var UUID: String?
    public var serial: String
    public var data: BeaconData

    init(beaconData: BeaconData) {

        self.data = beaconData
        self.serial = beaconData.serial

    }

    var firmwareVersion : String? {
        guard let device = StorageController.shared.loadDevice(serial: self.serial) else { return nil }
        return device["firmwareVersion"] as? String ?? nil
    }

    var hardwareVersion : String? {
        guard let device = StorageController.shared.loadDevice(serial: self.serial) else { return nil }
        return device["hardwareVersion"] as? String ?? nil
    }

    var latitude : Double? {
        guard let device = StorageController.shared.loadDevice(serial: self.serial) else { return nil }
        return device["latitude"] as? Double ?? 34.055569
    }

    var longitude : Double? {
        guard let device = StorageController.shared.loadDevice(serial: self.serial) else { return nil }
        return device["longitude"] as? Double ?? -117.182541
    }

    var accuracy : Int? {
        guard let device = StorageController.shared.loadDevice(serial: self.serial) else { return nil }
        return device["accuracy"] as? Int ?? 0
    }

    var seed : String? {
        guard let device = StorageController.shared.loadDevice(serial: self.serial) else { return nil }
        return device["seed"] as? String ?? nil
    }

    var isActivated : Bool {
        guard let device = StorageController.shared.loadDevice(serial: self.serial) else { return false }
        return device["isActivated"] as? Bool ?? false
    }

    var activationKey : String {
        return StorageController.shared.loadDeviceActivationKey(model: Int(self.data.model))
    }

    var isRegistered : Bool {

        if self.deviceKey != nil && self.isActivated {
            return true
        } else {
            return false
        }
    }

    var isPendingRegistration : Bool {

        if self.isActivated == true && self.isRegistered == false {
            return true
        } else {
            return false
        }
    }

    var deviceKey : String? {
        return StorageController.shared.loadDeviceKey(serial: self.serial)
    }

    var batteryPercentage : String {
        return String(self.data.battery) + "%"
    }

    var modelName: String {

        switch self.data.model {
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

        switch self.data.model {
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

    var service : [String : Any]? {

        let date = Date().toGMTDateString()

        guard let hardwareVersion = self.hardwareVersion,
            let firmwareVersion = self.hardwareVersion,
            let seed = self.seed,
            let latitude = self.latitude,
            let longitude = self.longitude,
            let accuracy = self.accuracy else { return nil }

        let object : [String : Any] = [
            "Serial": self.serial,
            "HardwareVersion": hardwareVersion,
            "FirmwareVersion": firmwareVersion,
            "DeviceModel": self.data.model,
            "Seed": seed,
            "Date": date,
            "Tempurature": self.data.temperature,
            "Battery": self.data.battery,
            "Detections": self.detections.map({$0.dictionary}),
            "Location" : [
                "Latitude": latitude,
                "Longitude": longitude,
                "Accuracy": accuracy,
                "Date": date
            ]
        ]
        return object
    }

    var detections : [TrapDetection] {

        guard let device = StorageController.shared.loadDevice(serial: self.serial),
            let detectionsObject = device["detections"],
            let detections = detectionsObject as? [[String : Any]]  else { return [] }

        return detections.map({TrapDetection(object: $0)})
    }

    func saveEvents(events: [DeviceEvent]){

        guard var device = StorageController.shared.loadDevice(serial: serial) else { return }
        var deviceEvents : [[String : Any]] = []
        var deviceDetections : [[String : Any]] = []

        for deviceEvent in events {
            let detectionDictArray = deviceEvent.detections.map({$0.toDictionary})
            let eventDict : [String : Any] = ["start" : deviceEvent.start,
                                              "end" : deviceEvent.end,
                                              "detections" : detectionDictArray]
            deviceDetections.append(contentsOf: detectionDictArray)
            deviceEvents.append(eventDict)
        }
        device["deviceEvents"] = deviceEvents
        device["detections"] = deviceDetections
        StorageController.shared.saveDevice(data: device, serial: serial)
    }

    func saveActivation(trapActivation: DeviceActivation){

        StorageController.shared.saveDevice(data: self.data.toDictionary, serial: self.serial)
        guard let device = StorageController.shared.loadDevice(serial: serial) else { return }
        var updatedDevice = device.merging(trapActivation.toDictionary){(_, new) in new}
        updatedDevice["isActivated"] = trapActivation.result
        StorageController.shared.saveDevice(data: updatedDevice, serial: serial)
    }

    func delete() {

        let cache = StorageController.shared.siteCache()

        cache.removeObject(forKey: self.serial)
         var deviceSerials = cache.stringArray(forKey: "deviceSerials") ?? [String]()
         deviceSerials.removeAll(where: {$0 == serial})
         cache.set(deviceSerials, forKey: "deviceSerials")

     }
}
