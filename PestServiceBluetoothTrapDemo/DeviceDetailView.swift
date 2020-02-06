//
//  DeviceDetailView.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/4/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import SwiftUI
import BellSensingBLE

struct DeviceDetailView: View {

    @ObservedObject var bluetoothController : BluetoothController
    var device : BeaconData

    var body: some View {
        VStack {

            Text("\(device.modelName)")
            Spacer()
            HStack {
                Button(action: {
                    self.bluetoothController.activateDevice(beaconData: self.device)
                }) {
                    Text("ACTIVATE")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding()
                        .border(Color.green, width: 5)
                }.padding()
                Spacer()
                Button(action: {
                    self.bluetoothController.deactivateDevice(beaconData: self.device)
                }) {
                    Text("DEACTIVATE")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .padding()
                        .border(Color.red, width: 5)
                }.padding()
                Spacer()
                Button(action: {
                    self.bluetoothController.downloadEvents(beaconData: self.device)
                }) {
                    Text("DOWNLOAD EVENTS")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding()
                        .border(Color.blue, width: 5)
                }.padding()
            }
        }
    }
}

//struct DeviceDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceDetailView()
//    }
//}
