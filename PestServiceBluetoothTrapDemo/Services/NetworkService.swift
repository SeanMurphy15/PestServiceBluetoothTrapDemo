//
//  AuthNetworkService.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/6/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import Foundation

class NetworkService {

    static let shared = NetworkService()

    func getAccessToken(completion: @escaping (_ isSuccess: Bool, _ message: String)-> Void) {

        let endpoint = "https://smartwave-smart-trap-sdk-dev.azurewebsites.net/token"
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let bodyStr:String = "grant_type=password&client_id=test&username=Ecolab&password=mMzgA6jT9GMbRjkofTJPM0tU"
        request.httpBody = bodyStr.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in

            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        StorageController.shared.saveAccessToken(accessToken: json["access_token"])
                        completion(true, "Access token retreived successfully")
                    } else {
                        completion(false, "Failed to serialize JSON data")
                    }
                } catch let error as NSError {
                    completion(false, "Failed to load: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }

    func getActivationAndDeviceKeys(completion: @escaping (_ isSuccess: Bool, _ message: String)-> Void) {

        let endpoint = "https://smartwave-smart-trap-sdk-dev.azurewebsites.net/api/Keys/\(StorageController.shared.siteId.uuidString)"
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        let accessToken = StorageController.shared.loadAccessToken()
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in

            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        StorageController.shared.saveActivationAndDeviceKeys(keys: json)
                        completion(true, "Activation and device keys retreived successfully")
                    } else {
                        completion(false, "Failed to serialize JSON data")
                    }
                } catch let error as NSError {
                    completion(false, "Failed to load: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }

    func getVersion(completion: @escaping (_ isSuccess: Bool, _ message: String)-> Void) {

        let endpoint = "https://smartwave-smart-trap-sdk-dev.azurewebsites.net/api/Version"
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        let accessToken = StorageController.shared.loadAccessToken()
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in

            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        StorageController.shared.saveActivationAndDeviceKeys(keys: json)
                        completion(true, "Bell Sensing Version retreived successfully")
                    } else {
                        completion(false, "Failed to serialize JSON data")
                    }
                } catch let error as NSError {
                    completion(false, "Failed to load: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}






