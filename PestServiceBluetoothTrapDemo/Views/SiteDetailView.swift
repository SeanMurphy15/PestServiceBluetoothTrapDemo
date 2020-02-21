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
        self.bluetoothController.scanForTraps()
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
                if bluetoothController.registeredTraps.count > 0 {
                    Section(header: Text("Registered")) {
                        ForEach(bluetoothController.registeredTraps) { trap in
                            TrapRowView(bluetoothController: self.bluetoothController, trap: trap)

                        }
                    }
                }
                if bluetoothController.unRegisteredTraps.count > 0 {
                    Section(header: Text("Connectable")) {
                        ForEach(bluetoothController.unRegisteredTraps) { trap in
                            TrapRowView(bluetoothController: self.bluetoothController, trap: trap)

                        }
                    }
                }

            }
            .navigationBarTitle(Text("Ecolab"), displayMode: .inline)
            .navigationBarItems(trailing:
                    Button(action: {
                        self.bluetoothController.scanForTraps()
                    }) {
                        Text("Refresh")
                })
            .listStyle(GroupedListStyle())
        }
    }
}

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
