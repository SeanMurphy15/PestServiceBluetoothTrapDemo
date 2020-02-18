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
                HStack{
                    if device.isActivated {
                        Text("Activated").foregroundColor(.green)
                    } else {
                        Text("Not Activated").foregroundColor(.gray)
                    }
                    if device.isRegistered {
                        Text("Registered").foregroundColor(.green)
                    } else {
                        Text("Not Registered").foregroundColor(.gray)
                    }
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
