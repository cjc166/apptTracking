//
//  API.swift
//  apptTracking
//
//  Created by Caleb Cain on 5/2/19.
//  Copyright © 2019 Caleb. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift

class API {
    
    static func getUserId() -> String {
        return UserDefaults.standard.value(forKey: "userId") as! String
    }
    
    static func setUserId(userId: String) {
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
    static func loginAttempt(username: String, password: String, completionHandler: @escaping (Bool, Any?, Error?) -> Void) {
        DispatchQueue.main.async {
            let parameters: [String: String] = ["username": username, "password": password]
            Alamofire.request("https://glacial-gorge-86115.herokuapp.com/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    if let result = response.result.value {
                        print(result)
                        let JSON = result as! NSDictionary
                        setUserId(userId: JSON["userid"]! as! String)
                        print(getUserId())
                    }
                    completionHandler(true, response, nil)
                case .failure(let error):
                    print (response)
                    print("FAILED TO LOGIN")
                    print(error)
                    completionHandler(false, response, nil)
                }
            }
        }
    }
    
    static func registrationAttempt(username: String, password: String, completionHandler: @escaping (Bool, Any?, Error?) -> Void) {
        let SUCCESS_CODE: Int
        SUCCESS_CODE = 200
        DispatchQueue.main.async {
            let parameters: [String: String] = ["username": username, "password": password]
            Alamofire.request("https://glacial-gorge-86115.herokuapp.com/register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                var statusCode: Int
                statusCode = response.response!.statusCode
                if (statusCode == SUCCESS_CODE) {
                    print("Validation Successful")
                    completionHandler(true, response, nil)
                } else {
                    print("Error")
                    completionHandler(false, response, nil)
                }
            }
        }
    }
    
    static func createAppointment(type: String, office: String, address: String, phoneNumber: String, date: String, time: String, numMonths: String, completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            let parameters: [String: String] = ["type": type, "office": office, "address": address, "phoneNumber": phoneNumber, "date": date, "time": time, "numMonths": numMonths]
            Alamofire.request("https://glacial-gorge-86115.herokuapp.com/addAppointment/" + getUserId() , method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                var statusCode: Int
                let SUCCESS_CODE = 200
                statusCode = response.response!.statusCode
                if (statusCode == SUCCESS_CODE) {
                    print("Validation Successful")
                    completionHandler(true)
                } else {
                    print("Error")
                    completionHandler(false)
                }
            }

        }
    }
    
    /*
     Perform networking code to access grocery list items for specific user
     */
    static func getAppointmentList(completionHandler: @escaping ([Appointment]) -> Void) {
        DispatchQueue.main.async {
            Alamofire.request("https://glacial-gorge-86115.herokuapp.com/appointments/" + getUserId(), method: .get, encoding: JSONEncoding.default).responseJSON{ response in
                switch response.result {
                case .success:
                    var appointmentList: [Appointment] = []
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        appointmentList = getStringArray(JSON)
                    }
                    completionHandler(appointmentList)
                case .failure:
                    print(getUserId())
                    print(response.result)
                    print(response)
                    print("Failure")
                    completionHandler([])
                }
            }
        }
    }
    
    static func getStringArray(_ appointments:NSDictionary) -> [Appointment] {
        
        let aList = appointments["appointments"] as! NSArray
        var appointmentList: [Appointment] = []
        
        if (aList.count > 0) {
            
            for i in 0...aList.count - 1 {
                let iAppt = aList[i] as! NSDictionary
                let type = iAppt["atype"] as! String
                let office = iAppt["office"] as! String
                let address = iAppt["address"] as! String
                let phoneNumber = iAppt["phoneNumber"] as! String
                let date = iAppt["date"] as! String
                let time = iAppt["time"] as! String
                let id = iAppt["id"] as! String
                
                let appointment = Appointment(phoneNumber: phoneNumber, address: address, type: type, time: time, office: office, date: date, id: id)
                
                appointmentList.append(appointment)
            }
        }
        return appointmentList
    }
    
    static func deleteAppointment(id: String, completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            let id: String = id
            let SUCCESS_CODE = 200
            let parameters: [String: String] = ["apptid": id]
            Alamofire.request("https://glacial-gorge-86115.herokuapp.com/removeAppointment/" + getUserId(), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                var statusCode: Int
                statusCode = response.response!.statusCode
                if (statusCode == SUCCESS_CODE) {
                    print("Deletion Successful")
                    completionHandler(true)
                } else {
                    print("Error")
                    completionHandler(false)
                }
            }
        }
    }
    
    static func passwordHash(username: String, password: String) -> String {
        let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
        return "\(password).\(username).\(salt)".sha256()
    }
}
