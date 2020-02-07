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

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.deviceScanner.endScan()
            for discoveredDevice in self.discoveredDevices {
                if let existingDevice = self.storage.loadDevice(serial: discoveredDevice.serial) {
                    let updatedDevice = existingDevice.merging(discoveredDevice.toDictionary){(_, new) in new}
                    self.storage.saveDevice(data: updatedDevice, serial: discoveredDevice.serial)
                } else {
                    self.storage.saveDevice(data: discoveredDevice.toDictionary, serial: discoveredDevice.serial)
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

        let result = deviceScanner.activateDevice(serial: beaconData.serial, siteId: storage.siteId, key: beaconData.activationKey)

        storage.updateDeviceActivationStatus(result: result, serial: beaconData.serial)

//        if let value = result as? Bool {
//            storage.updateDeviceActivationStatus(result: result, serial: beaconData.serial)
//        } else if let value = result as? DeviceActivation {
//            // save new DeviceActivation object
//        }

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
