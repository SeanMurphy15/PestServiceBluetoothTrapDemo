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


class BluetoothController: NSObject, ObservableObject, CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {}

    @Published var registeredDevices : [BeaconData] = []
    @Published var unRegisteredDevices : [BeaconData] = []

    private var discoveredDevices : [BeaconData] = [] {
        didSet {
            self.registeredDevices = discoveredDevices.filter({$0.isRegistered == true})
            self.unRegisteredDevices = discoveredDevices.filter({$0.isRegistered == false})
        }
    }

    private var centralManager: CBCentralManager!
    private var deviceScanner: DeviceScanner!
    private var storage : StorageController!

    override init() {
        super.init()
        storage = StorageController.shared
        centralManager = CBCentralManager(delegate: self, queue: nil)
        deviceScanner = DeviceScanner.getInstance(cbCentralManager: centralManager)
    }

    func startScan() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.deviceScanner.endScan()
            for discoveredDevice in self.discoveredDevices {
                self.storage.updateRegisteredDeviceAdvertisementData(beaconData: discoveredDevice)
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

        if beaconData.isRegistered == false {

            let deviceActivation = deviceScanner.activateDevice(serial: beaconData.serial, siteId: storage.siteId, key: beaconData.activationKey)

            if deviceActivation.result {

                storage.saveDevice(data: beaconData.toDictionary, serial: beaconData.serial)
                storage.updateDeviceActivation(deviceActivation: deviceActivation, serial: beaconData.serial)

            }
        }
    }

    // needs unique beacon DatadeviceKey after registering to site
    func deactivateDevice(beaconData: BeaconData){

        if beaconData.isRegistered {

            let deviceDeactivation = deviceScanner.deactivateDevice(serial: beaconData.serial, key: beaconData.deviceKey!)

            if deviceDeactivation{

                storage.deleteDevice(serial: beaconData.serial)

            }
        }
    }

    // needs unique beacon DatadeviceKey after registering to site
    func downloadEvents(beaconData: BeaconData){

        if beaconData.isRegistered {
            let events = deviceScanner.downloadEvents(beaconData: beaconData, serial: beaconData.serial, key: beaconData.deviceKey!, filterSeconds: 0) // keep filter seconds at zero for now
            storage.updateDeviceEvents(events: events, serial: beaconData.serial)
        }
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
