//
//  DeviceDetailView.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/4/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import SwiftUI
import BellSensingBLE


struct TrapDetailView: View {

    @ObservedObject var bluetoothController : BluetoothController
    @ObservedObject var trap : Trap
    @State var showingDetail = false

    var body: some View {
        
        VStack {
            List {
                Section(header: Text("Activity")) {
                        TrapDetectionChartView(trap: trap)
                            .padding([.bottom], 5)
                }
                Section(header: Text("Events / Detections")) {

                    HStack {
                        Text("Events")
                        Spacer()
                        Text("\(trap.data.eventsSinceLastService)")
                    }
                    HStack {
                        Text("Detections")
                        Spacer()
                        Text("\(trap.data.detectionsSinceLastService)")
                    }
                }
                Section(header: Text("Actions")) {
                    HStack {
                        Text("Download Event Data")
                        Spacer()
                        Button(action: {
                            self.bluetoothController.downloadEvents(trap: self.trap)
                        }) {
                            Image(systemName: "arrow.down.circle")
                        }.foregroundColor(Color.blue)
                    }.font(.headline)
                    HStack {
                        Text("Clear Event Data")
                        Spacer()
                        Button(action: {
                            print("Remove Device button was tapped")
                        }) {
                            Image(systemName: "arrow.clockwise.circle")
                        }.foregroundColor(Color.blue)
                    }.font(.headline)
                    HStack {
                        Text("Swap Device")
                        Spacer()
                        Button(action: {
                            print("Swap Device button was tapped")
                        }) {
                            Image(systemName: "arrow.right.arrow.left.circle")
                        }.foregroundColor(Color.blue)
                    }.font(.headline)
                    HStack {
                        Text("Delete Device")
                        Spacer()
                        Button(action: {
                            self.bluetoothController.deactivateTrap(trap: self.trap)
                        }) {
                            Image(systemName: "trash.circle")
                        }.foregroundColor(Color.red)
                    }.font(.headline)

                }
                Section(header: Text("Device Info")) {
                    HStack {
                        Text("Serial")
                        Spacer()
                        Text("\(trap.serial)")
                    }
                    HStack {
                        Text("RSSI")
                        Spacer()
                        Text("\(trap.data.rssi)")
                    }
                    HStack {
                        Text("Battery")
                        Spacer()
                        Text(trap.batteryPercentage)
                    }
                    HStack {
                        Text("Transmit Power")
                        Spacer()
                        Text("\(trap.data.transmitPower)")
                    }
                }
            }
        }
        .navigationBarTitle(Text("\(trap.modelName)"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.bluetoothController.sendTrapServiceData()

                //self.showingDetail = true
            }) {
                Text("Service")
            }.sheet(isPresented: self.$showingDetail) {
                TrapServiceView()
            }
        )
    }
}

//struct DeviceDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceDetailView()
//    }
//}

