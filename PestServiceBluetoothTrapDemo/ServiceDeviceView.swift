//
//  ServiceDeviceView.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/17/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import SwiftUI

struct ServiceDeviceView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var pests = ["Other", "Vole", "Mouse", "Cockroach", "RoofRat", "NorwayRat", "Chipmunk", "Squirrel", "DeerMouse", "WHTFTDMouse", "None"]

    var sex = ["NA", "AdultM", "AdultF", "PupM", "PupF"]

    @State private var selectedPest = 0
    @State private var selectedSex = 0
    @State private var baitType = ""
    @State private var baitUsed = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Captures")) {
                    Picker(selection: $selectedPest, label: Text("Pest Type")) {
                        ForEach(0 ..< pests.count) {
                            Text(self.pests[$0]).tag($0)
                        }
                    }
                    Picker(selection: $selectedSex, label: Text("Sex")) {
                        ForEach(0 ..< sex.count) {
                            Text(self.sex[$0]).tag($0)
                        }
                    }
                }
                Section(header: Text("Bait")) {
                    HStack {
                        Text("Bait Used")
                        Spacer()
                        TextField("", text: $baitUsed)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Bait Type")
                        Spacer()
                        TextField("", text: $baitType)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.trailing)
                    }
                }

            }
            .navigationBarTitle(Text("Service Device"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
            )
        }
    }
}

struct ServiceDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDeviceView()
    }
}
