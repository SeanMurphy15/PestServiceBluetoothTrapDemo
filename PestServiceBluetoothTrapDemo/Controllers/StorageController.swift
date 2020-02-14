//
//  StorageController.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/5/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import Foundation
import BellSensingBLE

class StorageController {

    static let shared = StorageController()

    let siteId = UUID(uuidString: "96b3b257-afcc-482d-aea7-a069f5329934")!
    var currentSerials : [String] = []

    func siteCache() -> UserDefaults {
        
        if let defaults = UserDefaults(suiteName: siteId.uuidString) {
            return defaults
        } else {
            return UserDefaults.init(suiteName: siteId.uuidString)!
        }
    }

    func authCache() -> UserDefaults {

        if let defaults = UserDefaults(suiteName: "auth") {
            return defaults
        } else {
            return UserDefaults.init(suiteName: "auth")!
        }
    }

    func saveVersion(data: [String : Any]?) {

        guard let data = data else { return }
        siteCache().set(data, forKey: "version")
    }

    func loadVersion() -> [String : Any]?{
        return siteCache().dictionary(forKey: "version")
    }

    func saveDevice(data: [String : Any], serial: String) {

        siteCache().set(data, forKey: serial)

        if let index = currentSerials.firstIndex(where: {$0 == serial}) {
            currentSerials[index] = serial
        } else {
            currentSerials.append(serial)
        }
    }

    func loadDevice(serial: String) -> [String : Any]?{

        if let device = siteCache().dictionary(forKey: serial) {
            return device
        } else {
            print("Device not found in storage")
            return nil
        }
    }

    func updateDeviceActivationStatus(result: Bool, serial: String) {

        guard var device = self.loadDevice(serial: serial) else { return }
        device["isActivated"] = result
        self.saveDevice(data: device, serial: serial)
    }

    func loadDeviceActivationStatus(serial: String) -> Bool {

        guard let device = self.loadDevice(serial: serial) else { return false }
        return device["isActivated"] as? Bool ?? false
    }

    func updateDeviceEvents(events: [DeviceEvent], serial: String){

        guard var device = self.loadDevice(serial: serial) else { return }
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
        // making detections shallow in the device tree for easier Visit POST access
        device["detections"] = deviceDetections
        self.saveDevice(data: device, serial: serial)

    }

    func updateDeviceActivation(deviceActivation: DeviceActivation, serial: String){

        guard let device = self.loadDevice(serial: serial) else { return }
        let updatedDevice = device.merging(deviceActivation.toDictionary){(_, new) in new}

        self.saveDevice(data: updatedDevice, serial: serial)
    }
    
    func loadDeviceKey(serial: String) -> String? {
        
        guard let adKeys = siteCache().dictionary(forKey: "activationAndDeviceKeys") else {
            print("Activation and device keys not found in storage")
            return nil
        }
        
        guard let dKeys = adKeys["Devices"] else {
            print("Device keys not found in storage")
            return nil
        }
        
        guard let deviceKeys = dKeys as? [[String : Any]] else {
            print("Unable to convert device keys to array")
            return nil
        }
        
        var result : String = ""

        for deviceKey in deviceKeys {
            guard let ds = deviceKey["Serial"] as? String,
                let dk = deviceKey["Key"] as? String else {
                    return nil
            }
            if serial == ds {
                result = dk
            }
        }

        if result == nil { print("Device key not found for serial") }

        return result
    }
    
    func saveActivationAndDeviceKeys(keys: [String : Any]?) {

        guard let keys = keys else { return }
        siteCache().setValue(keys, forKeyPath: "activationAndDeviceKeys")
        
    }
    
    func loadDeviceActivationKey(model: Int) -> String {
        
        guard let activationKeys = siteCache().dictionary(forKey: "activationAndDeviceKeys") else {
            print("Activation and device keys not found in storage")
            return ""
        }
        
        switch model {
        case 1:
            if let key = activationKeys["ExpressActivation"] as? String {
                return key
            } else {
                print("ExpressActivation key not found in storage")
            }
        case 2:
            if let key = activationKeys["AmbushActivation"] as? String {
                return key
            } else {
                print("ExpressActivation key not found in storage")
            }
        case 3:
            if let key = activationKeys["TrapperActivation"] as? String {
                return key
            } else {
                print("ExpressActivation key not found in storage")
            }
        case 4:
            if let key = activationKeys["TRexActivation"] as? String {
                return key
            } else {
                print("ExpressActivation key not found in storage")
            }
        default:
            print("No device model for key found in storage")
            return ""
        }
        print("No device model for key found in storage")
        return ""
    }

    func saveAccessToken(accessToken: Any?) {
        
        guard let token = accessToken else { return }
        authCache().setValue(token, forKeyPath: "accessToken")
        
    }
    
    func loadAccessToken() -> String {
        
        guard let token = authCache().value(forKey: "accessToken") else {
            print("Access token not found in storage")
            return ""
        }
        guard let accessToken = token as? String else {
            print("Unable to convert access token to string")
            return ""
        }
        return accessToken
    }

    func loadFormattedDevicesForVisit() -> [[String : Any]]?{

        let cache = siteCache()

        var deviceObjectArray : [[String : Any]] = []
        for serial in currentSerials {
            if let device = cache.object(forKey: serial) as? [String : Any] {
                var object : [String : Any] = [:]
                print("DEVICE -> <<<<<\(deviceObjectArray)>>>>>")

                object["Serial"] = device["serial"]
                object["HardwareVersion"] = device["hardwareVersion"]
                object["FirmwareVersion"] = device["firmwareVersion"]
                object["DeviceModel"] = device["model"]
                object["Seed"] = device["seed"]
                object["Date"] = formattedDate(date: Date())
                object["Temperature"] = device["temperature"]
                object["Battery"] = device["battery"]
                object["Detections"] = formattedDetections(device)
                object["Location"] = [
                  "Latitude": 34.055569,
                  "Longitude": -117.182541,
                  "Accuracy": 1,
                  "Date": StorageController.shared.formattedDate(date: Date())
                ]

                deviceObjectArray.append(object)
            }
        }

        print("SERVICE OBJECTS -> <<<<<\(deviceObjectArray)>>>>>")

        return deviceObjectArray
    }

    fileprivate func formattedDetections(_ device: [String : Any]) -> [[String : Any]] {

        guard let detectionsObject = device["detections"],
            let detections = detectionsObject as? [[String : Any]]  else { return [] }

        var formattedDetections : [[String : Any]] = []

        for detection in detections {
            guard let date = detection["time"] as? Date,
                let sensorSignature = detection["signature"] else { return formattedDetections }
            let formattedDetection = ["Date": formattedDate(date: date), "SensorSignature": sensorSignature]
            formattedDetections.append(formattedDetection)
        }

        return formattedDetections
    }

     func formattedDate(date : Date) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let formattedDate = formatter.string(from: date)
        print(formattedDate)
        return formattedDate
    }

    func printDeviceCache(serial: String? = nil) {

        let cache = siteCache()

        if serial == nil {
            var deviceArray : [[String : Any]] = []
            for serial in currentSerials {
                if let device = cache.object(forKey: serial) as? [String : Any] {
                    deviceArray.append(device)
                }
            }
            print("ALL CURRENT DEVICES -> \(deviceArray)")
        } else {
            guard let device = loadDevice(serial: serial!), let serial = serial else { return }
            print("DEVICE DATA FOR \(serial) -> \(device)")

        }

    }

    func printActivatioAndDeviceKeyCache() {

        print("ALL ACTIVATION AND DEVICE KEYS -> \(String(describing: siteCache().object(forKey: "activationAndDeviceKeys")))")

    }
    
    func printAuthCache() {
        
        print("AUTH CACHE ->: \(authCache().dictionaryRepresentation())")

    }
    
}


//        request.httpBody = [
//          [
//            "SiteId": "string",
//            "UserId": "string",
//            "Services": [
//              [
//                "Serial": "string",
//                "HardwareVersion": "string",
//                "FirmwareVersion": "string",
//                "DeviceModel": 0,
//                "Seed": "string",
//                "Date": "2020-02-13T19:03:04.689Z",
//                "Temperature": 0,
//                "Battery": 0,
//                "Detections": [
//                  [
//                    "Date": "2020-02-13T19:03:04.689Z",
//                    "SensorSignature": "string"
//                  ]
//                ],
//                "Location": [
//                  "Latitude": 0,
//                  "Longitude": 0,
//                  "Accuracy": 0,
//                  "Date": "2020-02-13T19:03:04.689Z"
//                ],
//                "Captures": [
//                  [
//                    "Type": "Vole",
//                    "Sex": "AdultM",
//                    "Count": 0
//                  ]
//                ],
//                "BaitUsed": 0,
//                "BaitType": "string"
//              ]
//            ],
//            "Reference": "string"
//          ]
//        ]
