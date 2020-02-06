//
//  BluetoothController.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/4/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import UIKit
import BellSensingBLE
import CoreBluetooth
import SwiftUI


class BluetoothController: NSObject, ObservableObject, CBCentralManagerDelegate, BluetoothDelegate {

    @Published var discoveredDevices : [BeaconData] = []

    private var centralManager: CBCentralManager!
    private var deviceScanner: DeviceScanner!


    override init() {
        super.init()

        centralManager = CBCentralManager(delegate: self, queue: nil)
        deviceScanner = DeviceScanner.getInstance(cbCentralManager: centralManager)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .resetting:
            print("Connection with the system service was momentarily lost. Update imminent")
        case .unsupported:
            print("Platform does not support the Bluetooth Low Energy Central/Client role")
        case .unauthorized:
            print("Unauthorized")
        case .poweredOff:
            print("Bluetooth is currently powered off")
        case .poweredOn:
            print("Bluetooth is currently powered on")
            startScan()
        default:
            print("Default: cleaning up cbManager")
        }
    }

    func startScan() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.deviceScanner.endScan()
            for discoveredDevice in self.discoveredDevices {
                if let existingDevice = StorageController.deviceCache().dictionary(forKey: discoveredDevice.serial) {
                    let updatedDevice = existingDevice.merging(discoveredDevice.toDictionary){(_, new) in new}
                    StorageController.deviceCache().set(updatedDevice, forKey: discoveredDevice.serial)
                } else {
                    StorageController.deviceCache().set(discoveredDevice.toDictionary, forKey: discoveredDevice.serial)
                }
            }
        }

        deviceScanner.startScan { (beaconData) in
            if let index = self.discoveredDevices.firstIndex(where: {$0.serial == beaconData.serial}) {
                self.discoveredDevices[index] = beaconData
            } else {
                self.discoveredDevices.append(beaconData)
            }
        }

    }

    func activateDevice(beaconData: BeaconData){

        if beaconData.isActivated { return }

        guard var dict = StorageController.deviceCache().dictionary(forKey: beaconData.serial) else { return }
        dict["isActivated"] = deviceScanner.activateDevice(serial: beaconData.serial, siteId: StorageController.siteId, key: beaconData.activationKey)
        StorageController.deviceCache().set(dict, forKey: beaconData.serial)
    }

    // needs unique beacon DatadeviceKey after registering to site
    func downloadEvents(beaconData: BeaconData){

        guard var dict = StorageController.deviceCache().dictionary(forKey: beaconData.serial) else { return }
        let events = deviceScanner.downloadEvents(beaconData: beaconData, serial: beaconData.serial, key: beaconData.activationKey, filterSeconds: 0)
        var deviceEvents : [[String : Any]] = []
        for deviceEvent in events {
            let detectionDictArray = deviceEvent.detections.map({$0.toDictionary})
            let eventDict : [String : Any] = ["start" : deviceEvent.start, "end" : deviceEvent.end, "detections": detectionDictArray]
            deviceEvents.append(eventDict)
        }
        dict["deviceEvents"] = deviceEvents
        StorageController.deviceCache().set(dict, forKey: beaconData.serial)

        print(StorageController.deviceCache().dictionary(forKey: beaconData.serial))

    }

    // needs unique beacon DatadeviceKey after registering to site
    func deactivateDevice(beaconData: BeaconData){

//        guard var dict = StorageController.deviceCache().dictionary(forKey: beaconData.serial) else { return }
//        dict["isActivated"] = !deviceScanner.deactivateDevice(serial: beaconData.serial, key: beaconData.deviceKey)
//        StorageController.deviceCache().set(dict, forKey: beaconData.serial)

    }


}

extension BeaconData : Identifiable, ObservableObject  {


    public var id : String {
        return self.serial
    }

     var isActivated : Bool {
        guard let dict = StorageController.deviceCache().dictionary(forKey: self.serial) else { return false }
        return dict["isActivated"] as? Bool ?? false
    }

    var batteryPercentage : String {

        return String(battery) + "%"
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

    // retrieve these values after get device keys request
    var activationKey : String {

        switch self.model {
        case 1:
            return "yjmW2c3vH/oGloxMdXSbpe6FBT18Xhm2jUVkJwckvHleO1+eBgEB"
        case 2:
            return "yjmW2c3vH/oGloxMdXSbpe6FBT18Xhm2jUVkJwckvHleO1+eBgIB"
        case 3:
            return "yjmW2c3vH/oGloxMdXSbpe6FBT18Xhm2jUVkJwckvHleO1+eBgMB"
        case 4:
            return "yjmW2c3vH/oGloxMdXSbpe6FBT18Xhm2jUVkJwckvHleO1+eBgQB"
        default:
            return ""
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

extension DeviceDetection {

    var toDictionary : [String : Any] {
        let mirror = Mirror(reflecting: self)
        let variableList: [(String, Any)] = mirror.children.compactMap {
            guard let label = $0.label else { return nil }
            return (label, $0.value)
        }
        return Dictionary(uniqueKeysWithValues: variableList)
    }

}
