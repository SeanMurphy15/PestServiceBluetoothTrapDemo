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
                completion(false, "\(#function) failed with error: \(error.localizedDescription)")
            } else {

                var result : [String : Any]?

                do {
                    result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                } catch let error as NSError {
                    completion(false, "\(#function) JSONSerialization failed to load: \(error.localizedDescription)")
                }

                if let httpUrlResponse = response as? HTTPURLResponse {
                    switch httpUrlResponse.statusCode {
                    case 200:
                        StorageController.shared.saveAccessToken(accessToken: result?["access_token"])
                        completion(true, "\(#function) retreived successfully with status code: \(httpUrlResponse.statusCode)")
                    default:
                        completion(false, "\(#function) failed with status code: \(httpUrlResponse.statusCode)")

                    }
                    print("\(#function) result: \(result ?? ["":""])")
                } else {
                    completion(false, "\(#function) failed to convert response to HTTPURLResponse")
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
                completion(false, "\(#function) failed with error: \(error.localizedDescription)")
            } else {

                var result : [String : Any]?

                do {
                    result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                } catch let error as NSError {
                    completion(false, " \(#function) JSONSerialization failed to load: \(error.localizedDescription)")
                }

                if let httpUrlResponse = response as? HTTPURLResponse {
                    switch httpUrlResponse.statusCode {
                    case 200:
                        StorageController.shared.saveActivationAndDeviceKeys(keys: result)
                        completion(true, "\(#function) retreived successfully with status code: \(httpUrlResponse.statusCode)")
                    default:
                        completion(false, "\(#function) failed with status code: \(httpUrlResponse.statusCode)")

                    }
                    print(" \(#function) result: \(result ?? ["":""])")
                } else {
                    completion(false, "\(#function) failed to convert response to HTTPURLResponse")
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
                completion(false, "\(#function) failed with error: \(error.localizedDescription)")
            } else {

                var result : [String : Any]?

                do {
                    result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                } catch let error as NSError {
                    completion(false, "\(#function) JSONSerialization failed to load: \(error.localizedDescription)")
                }

                if let httpUrlResponse = response as? HTTPURLResponse {
                    switch httpUrlResponse.statusCode {
                    case 200:
                        StorageController.shared.saveVersion(data: result)
                        completion(true, "\(#function) retreived successfully with status code: \(httpUrlResponse.statusCode)")
                    default:
                        completion(false, "\(#function) failed with status code: \(httpUrlResponse.statusCode)")

                    }
                    print(" \(#function) result: \(result ?? ["":""])")
                } else {
                    completion(false, "\(#function) failed to convert response to HTTPURLResponse")
                }
            }
        }
        task.resume()
    }

    func postVisit(traps: [Trap], completion: @escaping (_ isSuccess: Bool, _ message: String)-> Void) {

        guard let visitData = StorageController.shared.createVisitData(traps: traps) else {
            completion(false, "\(#function) failed with error: Visit data was nil.")
            return
        }

        let endpoint = "https://smartwave-smart-trap-sdk-dev.azurewebsites.net/api/Visit"
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        let accessToken = StorageController.shared.loadAccessToken()
        request.httpMethod = "POST"
        request.httpBody = visitData
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in

            if let error = error {
                completion(false, "\(#function) failed with error: \(error.localizedDescription)")
            } else {

                var result : [String : Any]?

                do {
                    result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                } catch let error as NSError {
                    completion(false, "\(#function) JSONSerialization failed to load: \(error.localizedDescription)")
                }

                if let httpUrlResponse = response as? HTTPURLResponse {
                    switch httpUrlResponse.statusCode {
                    case 200:
                        StorageController.shared.saveVersion(data: result)
                        completion(true, "\(#function) retreived successfully with status code: \(httpUrlResponse.statusCode)")
                    default:
                        completion(false, "\(#function) failed with status code: \(httpUrlResponse.statusCode)")

                    }
                    print(" \(#function) result: \(result ?? ["":""])")
                } else {
                    completion(false, "\(#function) failed to convert response to HTTPURLResponse")
                }
            }
        }
        task.resume()
    }
}







