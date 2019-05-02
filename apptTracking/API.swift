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
            Alamofire.request(/*login URL*/"", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        setUserId(userId: JSON["userid"]! as! String)
                        print(getUserId())
                    }
                    completionHandler(true, response, nil)
                case .failure(let error):
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
            Alamofire.request(/*registration URL*/"", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
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
    
    static func passwordHash(username: String, password: String) -> String {
        let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
        return "\(password).\(username).\(salt)".sha256()
    }
}
