//
//  NetworkController.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/6/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import Foundation

class NetworkController {

    static let shared = NetworkController()

    func getActivationAndDeviceKeysWithAccessToken() {

        let service = NetworkService.shared

        service.getAccessToken { (isSuccess, message) in
            if isSuccess {
                print(message)
                service.getActivationAndDeviceKeys { (isSuccess, message) in

                    if isSuccess {
                        print(message)
                        self.getVersion()
                    } else {
                        print(message)
                    }
                }
            } else {
                print(message)
            }
        }
    }


    func getVersion() {

        NetworkService.shared.getVersion { (isSuccess, message) in

            if isSuccess {
                print(message)

            } else {
                print(message)
            }
        }
    }

}
