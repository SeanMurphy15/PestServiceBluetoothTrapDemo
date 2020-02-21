//
//  DeviceDetailView.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/4/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import SwiftUI
import BellSensingBLE

 let moveChartData: [Int: Double] = [
    1: Double.random(in: 0...60),
    21: Double.random(in: 0...60),
    22: Double.random(in: 0...60),
    23: Double.random(in: 0...60),
    50: Double.random(in: 0...60),
    51: Double.random(in: 0...60),
    52: Double.random(in: 0...60),
    53: Double.random(in: 0...60),
    54: Double.random(in: 0...60),
    55: Double.random(in: 0...60),
    56: Double.random(in: 0...60),
    57: Double.random(in: 0...60),
    58: Double.random(in: 0...60),
    59: Double.random(in: 0...60),
    60: Double.random(in: 0...60),
    61: Double.random(in: 0...60),
    62: Double.random(in: 0...60),
    63: Double.random(in: 0...60),
    64: Double.random(in: 0...60),
    65: Double.random(in: 0...60),
    90: Double.random(in: 0...60),
    91: Double.random(in: 0...60),
    92: Double.random(in: 0...60),
    93: Double.random(in: 0...60),
    94: Double.random(in: 0...60),
    95: Double.random(in: 0...60)
]

struct TrapDetailView: View {

    @ObservedObject var bluetoothController : BluetoothController
    @ObservedObject var trap : Trap
    @State var showingDetail = false

    var body: some View {
        
        VStack {
            List {
                Section(header: Text("Activity")) {
                    HStack {
                            TrapDetectionChartView(
                            detections: 1,
                            data: moveChartData)
                            .padding([.bottom], 25)
                    }
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
                            print("Remove Device button was tapped")
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
                            print("Remove Device button was tapped")
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
                self.showingDetail = true
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

