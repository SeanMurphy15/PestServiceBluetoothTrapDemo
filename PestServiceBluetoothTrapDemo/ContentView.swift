//
//  ContentView.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/4/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import SwiftUI
import BellSensingBLE

struct ContentView: View {
    
    @ObservedObject var bluetoothController = BluetoothController()
    
    var body: some View {

        NavigationView {
            List(bluetoothController.discoveredDevices) { device in
                DeviceRow(bluetoothController: self.bluetoothController, device: device)
            }.navigationBarTitle(Text("Devices"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

