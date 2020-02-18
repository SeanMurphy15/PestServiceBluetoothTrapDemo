//
//  SiteDetailView.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/17/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import SwiftUI

struct SiteDetailView: View {

    @ObservedObject var bluetoothController = BluetoothController()

    init() {
        self.bluetoothController.startScan()
    }

    var body: some View {

        NavigationView {

            List {
                Section(header: Text("Address")) {
                    VStack(alignment: .leading) {
                        Text("1 Ecolab Place, St. Paul")
                        Text("MN 55102")
                    }.font(.headline)
                }
                if bluetoothController.registeredDevices.count > 0 {
                    Section(header: Text("Registered")) {
                        ForEach(bluetoothController.registeredDevices) { device in
                            DeviceRowView(bluetoothController: self.bluetoothController, device: device)

                        }
                    }
                }
                if bluetoothController.unRegisteredDevices.count > 0 {
                    Section(header: Text("Connectable")) {
                        ForEach(bluetoothController.unRegisteredDevices) { device in
                            DeviceRowView(bluetoothController: self.bluetoothController, device: device)

                        }
                    }
                }

            }
            .navigationBarTitle(Text("Ecolab"), displayMode: .inline)
            .navigationBarItems(trailing:
                    Button(action: {
                        self.bluetoothController.startScan()
                    }) {
                        Text("Refresh")
                })
            .listStyle(GroupedListStyle())
        }
    }
}

//struct SiteDetailView: View {
//    var body: some View {
//        VStack {
//
//            VStack {
//                Text("Devices")
//                Text("0/0")
//            }.padding(.bottom)
//            HStack{
//                VStack {
//                    Button(action: {
//                        print("Edit button was tapped")
//                    }) {
//                            Image(systemName: "plus")
//                    }.customButtonStyle()
//                    Text("Add Device")
//
//                    Button(action: {
//                        print("Edit button was tapped")
//                    }) {
//                            Image(systemName: "pencil")
//                    }.customButtonStyle()
//                    Text("Edit Device")
//                }
//                VStack{
//                    Button(action: {
//                        print("Edit button was tapped")
//                    }) {
//                            Image(systemName: "arrow.left.and.right")
//                    }.customButtonStyle()
//                    Text("Swap Device")
//
//                    Button(action: {
//                        print("Edit button was tapped")
//                    }) {
//                        Image(systemName: "list.bullet")
//                    }.customButtonStyle()
//                    Text("Device List")
//
//                }
//
//            }
//        }
//    }
//}

struct SiteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SiteDetailView()
    }
}

extension View {
    func customButtonStyle() -> some View {
        ModifiedContent(content: self, modifier: CustomButtonStyle())
    }
}

struct CustomButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .background(Color.blue)
        //.mask(Circle())
    }
}
