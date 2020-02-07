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

     func saveVersion(data: [String : Any]) {

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
        return siteCache().dictionary(forKey: serial)
    }

     func updateDeviceActivation(result: Bool, serial: String) {

        let cache = siteCache()

        guard var dict = cache.dictionary(forKey: serial) else { return }
        dict["isActivated"] = result

        cache.set(dict, forKey: serial)
    }

    func loadDeviceActiveStatus(serial: String) -> Bool {

        guard let dict = StorageController.shared.loadDevice(serial: serial) else { return false }
        return dict["isActivated"] as? Bool ?? false
    }

     func updateDeviceEvents(events: [DeviceEvent], serial: String){

        let cache = siteCache()

        guard var dict = cache.dictionary(forKey: serial) else { return }

        var deviceEvents : [[String : Any]] = []
        for deviceEvent in events {
            let detectionDictArray = deviceEvent.detections.map({$0.toDictionary})
            let eventDict : [String : Any] = ["start" : deviceEvent.start, "end" : deviceEvent.end, "detections": detectionDictArray]
            deviceEvents.append(eventDict)
        }
        dict["deviceEvents"] = deviceEvents
        cache.set(dict, forKey: serial)

    }
    
     func loadDeviceKey(serial: String) -> [String : Any]? {
        
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
        
        var result : [String : Any]? = nil
        
        for deviceKey in deviceKeys {
            if let ds = deviceKey["serial"] as? String {
                if serial == ds {
                    result = deviceKey
                }
            }
            
        }
        if result == nil {
            print("Device key not found for serial")
        }
        return result
    }
    
     func saveActivationAndDeviceKeys(keys: [String : Any]) {
        
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
    
     func printDeviceCache() {

        let cache = siteCache()

        print("ACTIVATION AND DEVICE KEYS -> \(String(describing: cache.object(forKey: "activationAndDeviceKeys")))")

        var deviceArray : [[String : Any]] = []
        for serial in currentSerials {
            if let device = cache.object(forKey: serial) as? [String : Any] {
                deviceArray.append(device)
            }
        }
        print("CURRENT DEVICES -> \(deviceArray)")
    }
    
     func printAuthCache() {
        
        print("AUTH CACHE ->: \(authCache().dictionaryRepresentation())")

    }
    
}
