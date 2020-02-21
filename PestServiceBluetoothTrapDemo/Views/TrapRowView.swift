//
//  DeviceRowView.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/7/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import SwiftUI
import BellSensingBLE

struct TrapRowView : View {

    @ObservedObject var bluetoothController : BluetoothController
    @ObservedObject var trap: Trap

    var body: some View {
        return NavigationLink(destination: TrapDetailView(bluetoothController: bluetoothController, trap: trap)) {
            VStack(alignment: .leading) {
                Text(trap.modelName).font(.headline)
                Text("Serial: \(trap.serial)").font(.subheadline)
                Text("Battery: \(trap.batteryPercentage)").font(.subheadline)
                Text("RSSI: \(trap.data.rssi)").font(.subheadline)
            }
        }
    }
}

//struct DeviceRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceRowView()
//    }
//}
