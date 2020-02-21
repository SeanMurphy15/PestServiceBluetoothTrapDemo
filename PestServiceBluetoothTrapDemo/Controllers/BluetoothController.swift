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

    @Published var registeredTraps : [Trap] = []
    @Published var unRegisteredTraps : [Trap] = []

    private var discoveredTraps : [Trap] = [] {
        didSet {
            self.registeredTraps = discoveredTraps.filter({$0.isRegistered == true})
            self.unRegisteredTraps = discoveredTraps.filter({$0.isRegistered == false})
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

    func scanForTraps() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.deviceScanner.endScan()
        }

        deviceScanner.startScan { (beaconData) in
            let trap = Trap(beaconData: beaconData)
            if let index = self.discoveredTraps.firstIndex(where: {$0.serial == trap.serial}) {
                self.discoveredTraps[index] = trap
            } else {
                self.discoveredTraps.append(trap)
            }
        }
    }


    func activateTrap(trap: Trap){

        if trap.isRegistered == false {
            let trapActivation = deviceScanner.activateDevice(serial: trap.serial, siteId: storage.siteId, key: trap.activationKey)
            if trapActivation.result {
                trap.saveActivation(trapActivation: trapActivation)
            }
        }
    }

    func deactivateTrap(trap: Trap){

        if trap.isRegistered {
            let trapDeactivation = deviceScanner.deactivateDevice(serial: trap.serial, key: trap.deviceKey!)
            if trapDeactivation {
                trap.delete()
            }
        }
    }

    func downloadEvents(trap: Trap){

        if trap.isRegistered {
            let events = deviceScanner.downloadEvents(beaconData: trap.data, serial: trap.serial, key: trap.deviceKey!, filterSeconds: 0) // keep filter seconds at zero for now
            trap.saveEvents(events: events)
        }
    }
}


