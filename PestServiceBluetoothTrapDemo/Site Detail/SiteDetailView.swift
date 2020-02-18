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

            VStack {
                Text("Magenic")
            }
            List {
                Section(header: Text("Site Info")) {
                    HStack {
                        Text("Discovered Devices")
                        Spacer()
                        NavigationLink(destination: DeviceListView(bluetoothController: bluetoothController), label: {
                            Text("")
                        })
                    }.font(.headline)
                }
                Section(header: Text("Actions")) {
                    HStack {
                        Text("Add Device")
                        Spacer()
                        Button(action: {
                            print("Edit button was tapped")
                        }) {
                            Image(systemName: "plus.circle")
                        }
                    }.font(.headline)
                    HStack {
                        Text("Remove Device")
                        Spacer()
                        Button(action: {
                            print("Edit button was tapped")
                        }) {
                            Image(systemName: "minus.circle")
                        }
                    }.font(.headline)
                    HStack {
                        Text("Swap Device")
                        Spacer()
                        Button(action: {
                            print("Edit button was tapped")
                        }) {
                            Image(systemName: "arrow.right.arrow.left.circle")
                        }
                    }.font(.headline)
                }


            }
            .navigationBarTitle(Text("Ecolab"), displayMode: .inline)
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
