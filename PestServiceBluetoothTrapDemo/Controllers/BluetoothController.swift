//
//  BluetoothController.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/4/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import UIKit
import BellSensingBLE.Swift
import CoreBluetooth
import SwiftUI


class BluetoothController: NSObject, ObservableObject, CBCentralManagerDelegate, BluetoothDelegate {

    @Published var discoveredDevices : [BeaconData] = []

    private var centralManager: CBCentralManager!
    private var deviceScanner: DeviceScanner!
    private var storage : StorageController!

    override init() {
        super.init()

        storage = StorageController.shared
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            self.deviceScanner.endScan()
            for discoveredDevice in self.discoveredDevices {
                if let existingDevice = self.storage.loadDevice(serial: discoveredDevice.serial) {
                    let updatedDevice = existingDevice.merging(discoveredDevice.toDictionary){(_, new) in new}
                    self.storage.saveDevice(data: updatedDevice, serial: discoveredDevice.serial)
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

        // possibly do an isRegisteredToSite?
        let deviceActivation = deviceScanner.activateDevice(serial: beaconData.serial, siteId: storage.siteId, key: beaconData.activationKey)

        if beaconData.isActivated == false && deviceActivation.result == true {

            storage.saveDevice(data: beaconData.toDictionary, serial: beaconData.serial)
            storage.updateDeviceActivation(deviceActivation: deviceActivation, serial: beaconData.serial)
            storage.updateDeviceActivationStatus(result: deviceActivation.result, serial: beaconData.serial)

        } else {

            storage.updateDeviceActivation(deviceActivation: deviceActivation, serial: beaconData.serial)

        }


        StorageController.shared.printDeviceCache(serial: beaconData.serial)

    }

    // needs unique beacon DatadeviceKey after registering to site
    func downloadEvents(beaconData: BeaconData){

        let events = deviceScanner.downloadEvents(beaconData: beaconData, serial: beaconData.serial, key: beaconData.activationKey, filterSeconds: 0) // keep filter seconds at zero for now
        storage.updateDeviceEvents(events: events, serial: beaconData.serial)

    }

    // needs unique beacon DatadeviceKey after registering to site
    func deactivateDevice(beaconData: BeaconData){

//        guard var dict = StorageController.deviceCache().dictionary(forKey: beaconData.serial) else { return }
//        dict["isActivated"] = !deviceScanner.deactivateDevice(serial: beaconData.serial, key: beaconData.deviceKey)
//        StorageController.deviceCache().set(dict, forKey: beaconData.serial)

    }


}

extension DeviceActivation {

    var toDictionary : [String : Any] {
        let mirror = Mirror(reflecting: self)
        let variableList: [(String, Any)] = mirror.children.compactMap {
            guard let label = $0.label else { return nil }
            return (label, $0.value)
        }
        return Dictionary(uniqueKeysWithValues: variableList)
    }
}
