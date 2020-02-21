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
        
        let cache = siteCache()
        cache.set(data, forKey: serial)
        
        var deviceSerials = cache.stringArray(forKey: "deviceSerials") ?? [String]()
        if let index = deviceSerials.firstIndex(where: {$0 == serial}) {
            deviceSerials[index] = serial
        } else {
            deviceSerials.append(serial)
        }
        cache.set(deviceSerials, forKey: "deviceSerials")
    }
    
    func loadDeviceSerials() -> [String] {
        
        siteCache().stringArray(forKey: "deviceSerials") ?? [String]()
    }
    
    func deleteDevice(serial: String) {
        
        let cache = siteCache()
        
        cache.removeObject(forKey: serial)
        var deviceSerials = cache.stringArray(forKey: "deviceSerials") ?? [String]()
        deviceSerials.removeAll(where: {$0 == serial})
        cache.set(deviceSerials, forKey: "deviceSerials")
        
    }

    
    func loadDevice(serial: String) -> [String : Any]?{
        
        if let device = siteCache().dictionary(forKey: serial) {
            return device
        } else {
            print("Device not found in storage")
            return nil
        }
    }
    

    
    func loadDeviceActivationStatus(serial: String) -> Bool {
        
        guard let device = self.loadDevice(serial: serial) else { return false }
        return device["isActivated"] as? Bool ?? false
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
        
        if result == "" { print("Device key not found for serial") }
        
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
    

    
    func printDeviceCache(serial: String? = nil) {
        
        let cache = siteCache()
        let currentSerials = loadDeviceSerials()
        
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
