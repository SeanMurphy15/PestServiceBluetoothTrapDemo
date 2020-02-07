//
//  DeviceRowView.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/7/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import SwiftUI
import BellSensingBLE

struct DeviceRow : View {

    @ObservedObject var bluetoothController : BluetoothController
    var device: BeaconData

    var body: some View {
        return NavigationLink(destination: DeviceDetailView(bluetoothController: bluetoothController, device: device)) {
            Image(device.imageName)
                .resizable()
                .frame(width: 100, height: 100, alignment: .leading)
                .cornerRadius(40)
            VStack(alignment: .leading) {
                Text(device.modelName).font(.headline)
                Text("RSSI: \(device.rssi)")
                Text("Battery: \(device.batteryPercentage)")
                if device.isActivated {
                    Text("Active").foregroundColor(.green)
                } else {
                    Text("Inactive").foregroundColor(.gray)
                }
            }
        }
    }
}

//struct DeviceRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceRowView()
//    }
//}
