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

//class TrapActivation : Identifiable, ObservableObject {
//
//    var firmwareVersion : String
//    var hardwareVersion : String
//    var seed : String
//    var dictionary : [String:Any] = [:]
//
//    init(object: [String : Any]) {
//        self.firmwareVersion = object["firmwareVersion"] as? String ?? "0"
//        self.hardwareVersion = object["hardwareVersion"] as? String ?? "0"
//        self.seed = object["seed"] as? String ?? "0"
////        self.dictionary["HardwareVersion"] = time?.toGMTDateString()
////        self.dictionary["SensorSignature"] = self.signature
//
//    }
//
//}


class Trap : Identifiable, ObservableObject {

    public var UUID: String?
    public var serial: String
    public var data: BeaconData

    init(beaconData: BeaconData) {

        self.data = beaconData
        self.serial = beaconData.serial

        if let existingDevice = StorageController.shared.loadDevice(serial: beaconData.serial) {
            let updatedDevice = existingDevice.merging(beaconData.toDictionary){(_, new) in new}
            StorageController.shared.saveDevice(data: updatedDevice, serial: beaconData.serial)
        }

    }

     var isActivated : Bool {
         return StorageController.shared.loadDeviceActivationStatus(serial: self.serial)
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

    func createService() -> [String : Any]? {

        let date = Date().toGMTDateString()
        guard let device = StorageController.shared.loadDevice(serial: self.serial) else { return nil }

                var object : [String : Any] = [:]

                object["Serial"] = device["serial"]
                object["HardwareVersion"] = device["hardwareVersion"]
                object["FirmwareVersion"] = device["firmwareVersion"]
                object["DeviceModel"] = device["model"]
                object["Seed"] = device["seed"]
                object["Date"] = date
                object["Temperature"] = device["temperature"]
                object["Battery"] = device["battery"]
                object["Detections"] = detections.map({$0.dictionary})
                object["Location"] = [
                    "Latitude": 34.055569,
                    "Longitude": -117.182541,
                    "Accuracy": 1,
                    "Date": date
                ]



//        let body = [
//            [
//                "SiteId": "96b3b257-afcc-482d-aea7-a069f5329934",
//                "UserId": "06cb0dc9-1e48-4d52-bb30-dfe512b0bf6d",
//                "Services": serviceObjectArray,
//                "Reference": "some reference"
//            ]
//        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("VISIT POST OBJECT <<<<<\(jsonString ?? "[]")>>>>>")
            return jsonData
        } catch let error {
            print("FUNCTION ERROR: \(self) \(#function) \(#line) : \(error.localizedDescription)")
            return nil
        }
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
                                              "end" : deviceEvent.end ]
            deviceDetections.append(contentsOf: detectionDictArray)
            deviceEvents.append(eventDict)
        }
        device["deviceEvents"] = deviceEvents
        device["detections"] = deviceDetections
        StorageController.shared.saveDevice(data: device, serial: serial)
    }

    func saveActivation(deviceActivation: DeviceActivation){

        StorageController.shared.saveDevice(data: self.data.toDictionary, serial: self.serial)
        guard let device = StorageController.shared.loadDevice(serial: serial) else { return }
        var updatedDevice = device.merging(deviceActivation.toDictionary){(_, new) in new}
        updatedDevice["isActivated"] = deviceActivation.result
        StorageController.shared.saveDevice(data: updatedDevice, serial: serial)
    }
}
