//
//  DeviceRowView.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/7/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import SwiftUI
import BellSensingBLE

struct DeviceRowView : View {

    @ObservedObject var bluetoothController : BluetoothController
    @ObservedObject var device: BeaconData

    var body: some View {
        return NavigationLink(destination: DeviceDetailView(bluetoothController: bluetoothController, device: device)) {
            VStack(alignment: .leading) {
                Text(device.modelName).font(.headline)
                Text("Serial: \(device.serial)").font(.subheadline)
                Text("Battery: \(device.batteryPercentage)").font(.subheadline)
                Text("RSSI: \(device.rssi)").font(.subheadline)
            }
        }
    }
}

//struct DeviceRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceRowView()
//    }
//}
