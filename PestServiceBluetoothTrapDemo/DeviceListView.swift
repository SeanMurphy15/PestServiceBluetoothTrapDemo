//
//  ContentView.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/4/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import SwiftUI
import BellSensingBLE

struct DeviceListView: View {
    
    @ObservedObject var bluetoothController : BluetoothController

    var body: some View {
        List {
            if bluetoothController.registeredDevices.count > 0 {
                Section(header: Text("Registered")) {
                    ForEach(bluetoothController.registeredDevices) { device in
                        DeviceRowView(bluetoothController: self.bluetoothController, device: device)

                    }
                }
            }
            if bluetoothController.unRegisteredDevices.count > 0 {
                Section(header: Text("Unregistered")) {
                    ForEach(bluetoothController.unRegisteredDevices) { device in
                        DeviceRowView(bluetoothController: self.bluetoothController, device: device)

                    }
                }
            }
        }.listStyle(GroupedListStyle())
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceListView()
//    }
//}

